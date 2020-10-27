<?php
import('lib.pkp.classes.plugins.ThemePlugin');
require_once('plugins/themes/psychopen/classes/XML_Parser.php');


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
		'awesome-cdn' => 'https://www.lifp.de/assets/scripts/font-awesome/5.14.0/css/all.min.css',
		'bootstrap' => 'https://www.lifp.de/assets/scripts/bootstrap/4.5.3/css/bootstrap.min.css',
	);

	/**
	 * Initiates the template and loads all required data into the template manager.
	 * @throws Exception
	 */
	public function init()
	{

		if ($this->getEnabled()) {
			// add external styles to template
			foreach ($this->external_styles as $k => $v) {
				$this->addStyle($k, $v, array('baseUrl' => ''));
			}
			// add external scripts to template
			/*foreach ($this->external_scripts as $k => $v) {
				$this->addScript($k, $v, array('baseUrl' => ''));
			}*/
			// add custom js to template
			$this->addScript('cookieConsent', 'https://lifp.de/assets/cookieConsentBannerStudy.min.js', array('baseUrl' => ''));
			$this->addScript('default', 'https://www.lifp.de/assets/psychopen/ojs_3_2/default.js', array('baseUrl' => ''));
			//$this->addScript('default', 'js/default.js');
			// add primary user to template (displayed in header)
			$this->addMenuArea(array('primary', 'user'));
			// template option: color scheme/style selector
			$this->addOption(
				'colorSchemeSelect',
				'radio',
				array(
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
				)
			);
			// choose css style by selection above. the folder name must match the option key. default is fallback option if none selected
			if (!empty($this->getOption('colorSchemeSelect'))) {
				$this->addStyle('psychopen', 'css/'.$this->getOption('colorSchemeSelect').'/psychopen.less');
			} else {
				$this->addStyle('psychopen', 'css/default/psychopen.less');
			}
			// template option: color scheme/style selector
			$this->addOption(
				'headerLogo',
				'text',
				array(
					'label' => 'plugins.themes.psychOpen.option.header.logo',
					'description' => 'plugins.themes.psychOpen.option.header.logo.desc',
				)
			);
			// template option: thumbnail for all issues (maybe for a better look of the archive)
			$this->addOption(
				'issueThumb',
				'text',
				array(
					'label' => 'plugins.themes.psychOpen.option.issueThumb',
					'description' => 'plugins.themes.psychOpen.option.issueThumb.desc',
				)
			);
			// template option: load sidebar on journal index page
			$this->addOption(
				'loadSideBar',
				'radio',
				array(
					'label' => 'plugins.themes.psychOpen.option.sidebar.label',
					'description' => 'plugins.themes.psychOpen.option.sidebar.desc',
					'options' => array(
						'index' => 'plugins.themes.psychOpen.option.sidebar.enable',
						'false' => 'plugins.themes.psychOpen.option.sidebar.disable',
					),
				)
			);
			// template option: issues can be sorted by year or volume. this is used for the issue sidebar plugin and the archive
			$this->addOption(
				'issueViewType',
				'radio',
				array(
					'label' => 'plugins.themes.psychOpen.option.section.header.issue.view',
					'description' => 'plugins.themes.psychOpen.option.section.header.issue.view.desc',
					'options' => array(
						'noSort' => 'plugins.themes.psychOpen.option.sidebar.issue.unsorted',
						'sortByYear' => 'plugins.themes.psychOpen.option.sidebar.issue.year',
						'sortByVolume' => 'plugins.themes.psychOpen.option.sidebar.issue.volume',
					),
				)
			);
			/* enable/disable section header on archive*/
			$this->addOption(
				'loadSectionHeaderIssue',
				'radio',
				array(
					'label' => 'plugins.themes.psychOpen.option.section.header.issue',
					'description' => 'plugins.themes.psychOpen.option.section.header.issue.desc',
					'options' => array(
						'true' => 'plugins.themes.psychOpen.option.sidebar.enable',
						'false' => 'plugins.themes.psychOpen.option.sidebar.disable',
					),
				)
			);
			// template option: enable/disable recent Articles on JournalPage
			$this->addOption(
				'loadRecentArticles',
				'radio',
				array(
					'label' => 'plugins.themes.psychOpen.option.recent.articles',
					'description' => 'plugins.themes.psychOpen.option.recent.articles.desc',
					'options' => array(
						'true' => 'plugins.themes.psychOpen.option.sidebar.enable',
						'false' => 'plugins.themes.psychOpen.option.sidebar.disable',
					),
				)
			);
			// template option: enable/disable latest issue on JournalPage
			$this->addOption(
				'showLatestIssue',
				'radio',
				array(
					'label' => 'plugins.themes.psychOpen.option.recent.issue',
					'description' => 'plugins.themes.psychOpen.option.recent.issue.desc',
					'options' => array(
						'true' => 'plugins.themes.psychOpen.option.sidebar.enable',
						'false' => 'plugins.themes.psychOpen.option.sidebar.disable',
					),
				)
			);
			// template option: enable/disable latest announcements on JournalPage
			$this->addOption(
				'showLatestAnnouncements',
				'radio',
				array(
					'label' => 'plugins.themes.psychOpen.option.recent.announcements',
					'description' => 'plugins.themes.psychOpen.option.recent.announcements.desc',
					'options' => array(
						'true' => 'plugins.themes.psychOpen.option.sidebar.enable',
						'false' => 'plugins.themes.psychOpen.option.sidebar.disable',
					),
				)
			);
			$this->addOption(
				'journalDescription',
				'FieldRichTextarea',
				[
					'label' => __('plugins.themes.psychOpen.option.journalDescription'),
					'description' => __('plugins.themes.psychOpen.option.journalDescription.desc'),
					'plugins' => 'paste link code image imagetools lists preview',
					'toolbar' => 'bold italic superscript subscript | numlist bullist | link | code | image | preview',
					//'isMultilingual' => true  // TODO this does not work at the moment: https://github.com/pkp/pkp-lib/issues/6186
				]
			);
			HookRegistry::register('LoadHandler', array($this, 'callbackLoadHandler'));
			HookRegistry::register('TemplateManager::display', array($this, 'loadTemplateData'));
			// loads the IssueBlock as BlockPlugin to make it available and sortable in the sidebar
			$this->import('IssueBlockPlugin');
			$blockPlugin = new IssueBlockPlugin();
			PluginRegistry::register('blocks', $blockPlugin, $this->getPluginPath());
		}
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
		$request = Application::get()->getRequest();
		$context = $request->getContext();
		// TODO anders laden über load handler ansonsten wird das immer geladen
		if ($context != null && $context->getId() != null && $context->getId() > 0) {
			$publishedIterator = Services::get('issue')->getMany(
				[
					'contextId' => $context->getId(),
					'isPublished' => true,
				]
			);
			$templateMgr->assign('issues_full', iterator_to_array($publishedIterator));
		}
		$imageUrl = $request->getBaseUrl() .'/'.$this->getPluginPath()."/images/";

		$templateMgr->assign(
			array(
				'imageURL' => $imageUrl,
				'issueThumb' => $this->getOptionValues($context->getId())['issueThumb'],
				'loadSideBar' => $this->getOptionValues($context->getId())['loadSideBar'],
				'loadSectionHeaderIssue' => $this->getOptionValues($context->getId())['loadSectionHeaderIssue'],
				'loadRecentArticles' => $this->getOptionValues($context->getId())['loadRecentArticles'],
				'showLatestIssue' => $this->getOptionValues($context->getId())['showLatestIssue'],
				'showLatestAnnouncements' => $this->getOptionValues($context->getId())['showLatestAnnouncements'],
				'issueViewType' => $this->getOptionValues($context->getId())['issueViewType'],
				'headerLogo' => $this->getOptionValues($context->getId())['headerLogo'],
				'mailingAddress' => $context ? $context->getData('mailingAddress') : "",
				'contactPhone' => $context ? $context->getData('contactPhone') : "",
				'contactEmail' => $context ? $context->getData('contactEmail') : "",
				'contactName' => $context ? $context->getData('contactName') : "",
				'supportName' => $context ? $context->getData('supportName') : "",
				'supportPhone' => $context ? $context->getData('supportPhone') : "",
				'supportEmail' => $context ? $context->getData('supportEmail') : "",
				'contactTitle' => $context ? $context->getLocalizedData('contactTitle') : "",
				'contactAffiliation' => $context ? $context->getLocalizedData('contactAffiliation') : "",
				'onlineIssn' => $context ? $context->getData('onlineIssn') : "",
				'printIssn' => $context ? $context->getData('printIssn') : "",
			)
		);
	}

	public function callbackLoadHandler($hookName, $args)
	{
		$page = $args[0];
		$request = Application::get()->getRequest();
		$context = $request->getContext();
		$contextId = $context == null ? 0 : $context->getId();
		$templateMgr = TemplateManager::getManager($request);
		switch ("$page") {
			case 'index':
			case '':
				$templateMgr->assign('journalDescriptionCustom', $this->getOptionValues($context->getId())['journalDescription']);
				$templateMgr->assign('recentArticles', $this->_loadRecentArticles(true, $contextId));
				$publishedIterator = Services::get('issue')->getMany(['contextId' => $context->getId(), 'isPublished' => true,]);
				$templateMgr->assign('issues_full', iterator_to_array($publishedIterator));
				break;
			case 'article':
			case 'issue':
			case 'search':
			case 'catalog':
				$templateMgr->register_function('loadCategoryBySubmission', array(&$this, 'loadCategoryBySubmission'));
				$templateMgr->register_function('loadDataFromXML', array(&$this, 'loadDataFromXML'));
				$templateMgr->register_function('getAbstractViews', array(&$this, 'getAbstractViews'));
				break;
		}

		$templateMgr->assign('footerMenu', $this->_loadFooterMenu("Footer", $contextId));
	}

	/**
	 * This function loads the last five published articles for the " Recent Articles " section on the index page of the journal.
	 *
	 * @param $loadRecentArticles
	 * @param $contextId
	 * @return array true result size > 0, otherwise false
	 */
	private function _loadRecentArticles($loadRecentArticles, $contextId)
	{
		$ret = null;
		if ($loadRecentArticles == "true") {
			$submissionsIterator = Services::get('submission')->getMany(
				[
					'contextId' => $contextId,
					'status' => 3,
					'count' => 25,
				]
			);
			if (isset($submissionsIterator)) {
				$arr = iterator_to_array($submissionsIterator);
				shuffle($arr);
				$ret = array_slice($arr, 0, 5);
			}
		}

		return $ret;
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
	private function _loadFooterMenu($footerMenuTitle, $contextId)
	{
		$navigationMenuDao = DAORegistry::getDAO('NavigationMenuDAO');
		$navigationMenuItems = null;
		if ($navigationMenuDao->navigationMenuExistsByTitle($contextId, $footerMenuTitle)) {
			$navigationMenu = $navigationMenuDao->getByTitle($contextId, $footerMenuTitle);
			if (isset($navigationMenu)) {
				$navigationMenuItemDao = DAORegistry::getDAO('NavigationMenuItemDAO');
				$navigationMenuItems = $navigationMenuItemDao->getByMenuId($navigationMenu->getId())->toArray();
			}
		}

		return $navigationMenuItems;
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
		$categories = $categoryDao->getByPublicationId($params['submissionId'])->toArray();
		$ret = array();
		foreach ($categories as $value) {
			array_push($ret, $categoryDao->getById($value->getId(), $value->getContextId(), $value->getParentId()));
		}
		$smarty->assign('articleCat', $ret);

		return sizeof($ret) > 0;
	}


	/**
	 *
	 * @param $params array : list of parameters
	 * @param $smarty TemplateManager
	 * @return bool
	 */
	public function loadDataFromXML($params, $smarty)
	{
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
		$application = Application::get();
		$fileId = $params['fileId'];
		if ($fileId) {
			return $application->getPrimaryMetricByAssoc(ASSOC_TYPE_SUBMISSION, $fileId);
		}

		return 0;
	}
}
