<?php
import('lib.pkp.classes.plugins.ThemePlugin');
require_once 'classes/XML_Parser.php';

/**
 * PsychOpenThemePlugin
 *
 * This plugin is an OJS 3.x ThemePlugin.
 *
 * features:
 * - full support of Bootstrap 4.x
 * - customizable Journal Index (optional sidebar, recent articles, issues, announcements)
 * - simple addition of new color schemes
 * - crossref, scopus, google scholar and europepmc integration
 * - html and pfd viewer fully integrated into theme (overwriting of generic tpl files)
 * - sort function of issues(unsorted, by date or by volume)
 * - custom 'how to cite' function based on JATS XML data
 * - altmetric and dimension integration
 * - customizable footer menu
 * - contact information in the footer
 * - hidden search in the header
 * - reactivated advanced search filters (by title, by keywords and order by)
 * - reactivated author index
 * - optional (clickable) category badges in the article details
 *
 * @file plugins/themes/ojs_theme/PsychOpenThemePlugin.inc.php
 *
 * Copyright (2019) Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @category   ThemePlugin
 * @author     Ronny Bölter <rb@leibniz-psychology.org>
 * @link       https://github.com/RBoelter/ojs_theme
 */
class PsychOpenThemePlugin extends ThemePlugin
{
    /**
     * List of external JavaScript/jQuery libs
     *
     * @var $external_scripts array
     */
    private $external_scripts = array(
        'jquery' => 'https://code.jquery.com/jquery-3.4.1.min.js',
        'popper' => 'https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js',
        'bootstrap' => 'https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js',
        'altmetric-cdn' => 'https://d1bxh8uas1mnw7.cloudfront.net/assets/embed.js',
        'dimensions-cdn' => 'https://badge.dimensions.ai/badge.js',
        /*'cookieConsent' => 'https://www.lifp.de/assets/cookieConsentBanner.js',*/
    );

    /**
     * List of external css libs
     *
     * @var $external_styles array
     */
    private $external_styles = array(
        'opensans-cdn' => 'https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i&display=swap',
        'roboto-cdn' => 'https://fonts.googleapis.com/css?family=Roboto',
        'slabo27px-cdn' => 'https://fonts.googleapis.com/css?family=Slabo+27px',
        'awesome-cdn' => 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css',
        'bootstrap' => 'https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css'
    );

    /**
     * Initiates the template and loads all required data into the template manager.
     */
    public function init()
    {
        // add external styles to template
        foreach ($this->external_styles as $k => $v) {
            $this->addStyle($k, $v, array('baseUrl' => ''));
        }
        // add external scripts to template
        /*foreach ($this->external_scripts as $k => $v) {
            $this->addScript($k, $v, array('baseUrl' => ''));
        }*/
        // add custom js to template
        /*$this->addScript('cookieConsent', 'js/cookieConsentBannerStudy.min.js');*/
        $this->addScript('cookieConsent', 'https://lifp.de/assets/cookieConsentBannerStudy.min.js', array('baseUrl' => ''));
	    $this->addScript('default', 'https://www.lifp.de/assets/psychopen/ojs_3_1/default.js', array('baseUrl' => ''));
        //$this->addScript('default', 'js/default.js');
        /*$this->addScript('psychopen', 'js/psychopen.js');*/

        // add primary user to template (displayed in header)
        $this->addMenuArea(array('primary', 'user'));
        // template option: color scheme/style selector
        $this->addOption('colorSchemeSelect', 'radio', array(
            'label' => 'plugins.themes.psychOpen.option.scheme',
            'description' => 'plugins.themes.psychOpen.option.scheme.desc',
            'options' => array(
                'cpe' => 'plugins.themes.psychOpen.option.scheme.cpe',
                'default' => 'plugins.themes.psychOpen.option.scheme.default',
                'ejop' => 'plugins.themes.psychOpen.option.scheme.ejop',
                'ijpr' => 'plugins.themes.psychOpen.option.scheme.ijpr',
                'meth' => 'plugins.themes.psychOpen.option.scheme.meth',
                'ps' => 'plugins.themes.psychOpen.option.scheme.ps',
                'qcmb' => 'plugins.themes.psychOpen.option.scheme.qcmb',
                'sotrap' => 'plugins.themes.psychOpen.option.scheme.sotrap',
                'spb' => 'plugins.themes.psychOpen.option.scheme.spb',
                'jbdgm' => 'plugins.themes.psychOpen.option.scheme.jbdgm',
            ),
        ));
        // choose css style by selection above. the folder name must match the option key. default is fallback option if none selected
        if (!empty($this->getOption('colorSchemeSelect')))
            $this->addStyle('psychopen', 'css/' . $this->getOption('colorSchemeSelect') . '/psychopen.less');
        else
            $this->addStyle('psychopen', 'css/default/psychopen.less');
        // template option: color scheme/style selector
        $this->addOption('headerLogo', 'text', array(
            'label' => 'plugins.themes.psychOpen.option.header.logo',
            'description' => 'plugins.themes.psychOpen.option.header.logo.desc',
        ));
        // template option: thumbnail for all issues (maybe for a better look of the archive)
        $this->addOption('issueThumb', 'text', array(
            'label' => 'plugins.themes.psychOpen.option.issueThumb',
            'description' => 'plugins.themes.psychOpen.option.issueThumb.desc',
        ));
        // template option: load sidebar on journal index page
        $this->addOption('loadSideBar', 'radio', array(
            'label' => 'plugins.themes.psychOpen.option.sidebar.label',
            'description' => 'plugins.themes.psychOpen.option.sidebar.desc',
            'options' => array(
                'index' => 'plugins.themes.psychOpen.option.sidebar.enable',
                'false' => 'plugins.themes.psychOpen.option.sidebar.disable',
            ),
        ));
        // template option: issues can be sorted by year or volume. this is used for the issue sidebar plugin and the archive
        $this->addOption('issueViewType', 'radio', array(
            'label' => 'plugins.themes.psychOpen.option.section.header.issue.view',
            'description' => 'plugins.themes.psychOpen.option.section.header.issue.view.desc',
            'options' => array(
                'noSort' => 'plugins.themes.psychOpen.option.sidebar.issue.unsorted',
                'sortByYear' => 'plugins.themes.psychOpen.option.sidebar.issue.year',
                'sortByVolume' => 'plugins.themes.psychOpen.option.sidebar.issue.volume',
            ),
        ));
        /* enable/disable section header on archive*/
        $this->addOption('loadSectionHeaderIssue', 'radio', array(
            'label' => 'plugins.themes.psychOpen.option.section.header.issue',
            'description' => 'plugins.themes.psychOpen.option.section.header.issue.desc',
            'options' => array(
                'true' => 'plugins.themes.psychOpen.option.sidebar.enable',
                'false' => 'plugins.themes.psychOpen.option.sidebar.disable',
            ),
        ));
        // template option: enable/disable recent Articles on JournalPage
        $this->addOption('loadRecentArticles', 'radio', array(
            'label' => 'plugins.themes.psychOpen.option.recent.articles',
            'description' => 'plugins.themes.psychOpen.option.recent.articles.desc',
            'options' => array(
                'true' => 'plugins.themes.psychOpen.option.sidebar.enable',
                'false' => 'plugins.themes.psychOpen.option.sidebar.disable',
            ),
        ));
        // template option: enable/disable latest issue on JournalPage
        $this->addOption('showLatestIssue', 'radio', array(
            'label' => 'plugins.themes.psychOpen.option.recent.issue',
            'description' => 'plugins.themes.psychOpen.option.recent.issue.desc',
            'options' => array(
                'true' => 'plugins.themes.psychOpen.option.sidebar.enable',
                'false' => 'plugins.themes.psychOpen.option.sidebar.disable',
            ),
        ));
        // template option: enable/disable latest announcements on JournalPage
        $this->addOption('showLatestAnnouncements', 'radio', array(
            'label' => 'plugins.themes.psychOpen.option.recent.announcements',
            'description' => 'plugins.themes.psychOpen.option.recent.announcements.desc',
            'options' => array(
                'true' => 'plugins.themes.psychOpen.option.sidebar.enable',
                'false' => 'plugins.themes.psychOpen.option.sidebar.disable',
            ),
        ));
        // Hook which loads more data to the template manager
        HookRegistry::register('TemplateManager::display', array($this, 'loadTemplateData'));
        // loads the IssueBlock as BlockPlugin to make it available and sortable in the sidebar
        $this->import('IssueBlockPlugin');
        $blockPlugin = new IssueBlockPlugin($this);
        PluginRegistry::register('blocks', $blockPlugin, $this->getPluginPath());
    }

    /**
     * Get the display name of this plugin
     * @return string
     */
    function getDisplayName()
    {
        return __('plugins.themes.psychOpen.name');
    }

    /**
     * Get the description of this plugin
     * @return string
     */
    function getDescription()
    {
        return __('plugins.themes.psychOpen.description');
    }

    /**
     * Unused
     *
     * @param $hookName
     * @param $params
     * @return bool
     */
    public function downloadCitation($hookName, $params)
    {
        $smarty =& $params[1];
        $output =& $params[2];
        $output .= $smarty->fetch($this->getTemplateResource('frontend/components/export_citation.tpl'));
        return false;
    }

    /**
     * Adds additional dat to the smarty template manager
     *
     * @param $hookName string :  Name of the Hook
     * @param $args array : list of arguments
     */
    public function loadTemplateData($hookName, $args)
    {
        $templateMgr = $args[0];
        $request = Application::getRequest();
        $context = $request->getContext();
        $journal = $request->getJournal();
        // loads a full list of all issues to the template. This is needed because of the sorting functionality.
        // If issue sorting is enabled, then all issues are shown in the archive and the pagination is disabled
        $issueDao = DAORegistry::getDAO('IssueDAO');
        if ($journal) {
            $issues = $issueDao->getPublishedIssues($journal->getId());
            $templateMgr->assign('issues_full', $issues->toArray());
        }
        // set the url to the image folder of this plugin
        $keywords = explode('/', $_SERVER['REQUEST_URI']);
        $imageUrl = "/plugins/themes/psychOpen/images/";
        if (sizeof($keywords) > 2 && $keywords[1] != 'index.php') {
            $imageUrl = "/" . $keywords[1] . "/plugins/themes/psychOpen/images/";
        }
        // assign template options and other default values to the template (e.g. template wide contact information because they are shown in the footer)
        $templateMgr->assign(array(
            'imageURL' => $imageUrl,
            'issueThumb' => $this->getOption('issueThumb'),
            'loadSideBar' => $this->getOption('loadSideBar'),
            'sidebarIssues' => $this->getOption('sidebarIssues'),
            'loadSectionHeaderIssue' => $this->getOption('loadSectionHeaderIssue'),
            'loadRecentArticles' => $this->getOption('loadRecentArticles'),
            'showLatestIssue' => $this->getOption('showLatestIssue'),
            'showLatestAnnouncements' => $this->getOption('showLatestAnnouncements'),
            'issueViewType' => $this->getOption('issueViewType'),
            'headerLogo' => $this->getOption('headerLogo'),
            'mailingAddress' => $context ? $context->getSetting('mailingAddress') : "",
            'contactPhone' => $context ? $context->getSetting('contactPhone') : "",
            'contactEmail' => $context ? $context->getSetting('contactEmail') : "",
            'contactName' => $context ? $context->getSetting('contactName') : "",
            'supportName' => $context ? $context->getSetting('supportName') : "",
            'supportPhone' => $context ? $context->getSetting('supportPhone') : "",
            'supportEmail' => $context ? $context->getSetting('supportEmail') : "",
            'contactTitle' => $context ? $context->getLocalizedSetting('contactTitle') : "",
            'contactAffiliation' => $context ? $context->getLocalizedSetting('contactAffiliation') : "",
            'onlineIssn' => $context ? $context->getSetting('onlineIssn') : "",
            'printIssn' => $context ? $context->getSetting('printIssn') : ""
        ));
        // register additional functions
        $templateMgr->register_function('loadCategoryBySubmission', array(&$this, 'loadCategoryBySubmission'));
        $templateMgr->register_function('loadRecentArticles', array(&$this, 'loadRecentArticles'));
        $templateMgr->register_function('loadCurrentURI', array(&$this, 'loadCurrentURI'));
        $templateMgr->register_function('loadDataFromXML', array(&$this, 'loadDataFromXML'));
        $templateMgr->register_function('loadFooterMenu', array(&$this, 'loadFooterMenu'));
        $templateMgr->register_function('getAbstractViews', array(&$this, 'getAbstractViews'));
    }

    /**
     * This function registers a customizable footer menu.
     * For this a menu must be created on the administration page Settings->Website->Navigation Menus.
     * The name of the menu must be "Footer", otherwise the menu will not be displayed.
     * TODO At the moment not all types of links are working! External links and custom pages work well.
     *
     * @param $params array : list of parameters
     * @param $smarty TemplateManager
     * @return bool true if menu is successfully loaded, otherwise false
     */
    public function loadFooterMenu($params, $smarty)
    {
        $request = Application::getRequest();
        $journal = $request->getJournal();
        $navigationMenuDao = DAORegistry::getDAO('NavigationMenuDAO');
        if ($navigationMenuDao->navigationMenuExistsByTitle($journal->getId(), $params['footerMenuTitle'])) {
            $navigationMenu = $navigationMenuDao->getByTitle($journal->getId(), $params['footerMenuTitle']);
            if (isset($navigationMenu)) {
                $navigationMenuItemDao = DAORegistry::getDAO('NavigationMenuItemDAO');
                $navigationMenuItems = $navigationMenuItemDao->getByMenuId($navigationMenu->getId())->toArray();
                $smarty->assign('footerMenu', $navigationMenuItems);
                return true;
            }
        }
        return false;
    }

    /**
     * This theme supports badges with the article categories in the article details. These badges are linked to the category overview.
     * Therefore, this function is needed to load the categories that belong to an article.
     *
     * @param $params array : list of parameters
     * @param $smarty TemplateManager
     * @return bool true result size > 0, otherwise false
     */
    public function loadCategoryBySubmission($params, $smarty)
    {
        $categoryDao = DAORegistry::getDAO('CategoryDAO');
        $categories =& $categoryDao->getBySubmissionId($params['submissionId']);
        $ret = array();
        foreach ($categories as $value) {
            array_push($ret, $categoryDao->getById($value['id'], $value['context_id'], $value['parent_id']));
        }
        $smarty->assign('articleCat', $ret);
        return (sizeof($ret) > 0) ? true : false;
    }

    /**
     * This function loads the last five published articles for the " Recent Articles " section on the index page of the journal.
     *
     * @param $params array : list of parameters
     * @param $smarty TemplateManager
     * @return bool true result size > 0, otherwise false
     */
    public function loadRecentArticles($params, $smarty)
    {
        if ($params['loadRecentArticles'] == "true") {
            $publishedArticleDao = DAORegistry::getDAO('PublishedArticleDAO');
            $request = Application::getRequest();
            $journal = $request->getJournal();
            $publishedArticleObjects = $publishedArticleDao->getPublishedArticlesByJournalId($journal->getId(), $rangeInfo = new DBResultRange(25), $reverse = true);
            $arr = $publishedArticleObjects->toArray();
            $rand = array_rand($arr, 5);
            $ret = [];
            foreach ($rand as $r) {
                array_push($ret, $arr[$r]);
            }

            $smarty->assign('recentArticles', $ret);
            return (sizeof($ret) > 0) ? true : false;
        } else {
            return false;
        }
    }

    /**
     * Returns the actual URL to the View
     *
     * @param $params array : list of parameters
     * @param $smarty TemplateManager
     * @return string The current URL
     */
    public function loadCurrentURI($params, $smarty)
    {
        if (isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on") {
            $pro = 'https';
        } else {
            $pro = 'http';
        }
        $port = ($_SERVER["SERVER_PORT"] == "80") ? "" : (":" . $_SERVER["SERVER_PORT"]);
        return $pro . "://" . $_SERVER['SERVER_NAME'] . $port . $_SERVER['REQUEST_URI'];
    }

    /**
     *
     * @param $params array : list of parameters
     * @param $smarty TemplateManager
     * @return bool
     */
    public function loadDataFromXML($params, $smarty)
    {
        error_log("######################");
        $citeList = array();
        $xml_parser = new XML_Parser();
        if ($xml_parser->loadXML($params['xmlUri'], $params['locale'])) {
            $citeList['American Psychological Association (APA)'] = $xml_parser->buildAPACite();
            $suppList = $xml_parser->buildSupplementList();
            if (sizeof($suppList) > 0) {
                $smarty->assign('suppList', $suppList);
            }
            if (sizeof($citeList) > 0) {
                $smarty->assign('citeList', $citeList);
                return true;
            }
        }
        return false;
    }

    public function getAbstractViews($params, $smarty)
    {
        $application = PKPApplication::getApplication();
        $fileId = $params['fileId'];
        if ($fileId) {
            return $application->getPrimaryMetricByAssoc(ASSOC_TYPE_SUBMISSION, $fileId);
        }
        return 0;
    }
}
