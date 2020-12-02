{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article which displays all details about the article. Expected to be primary object on the page.
 *
 * Core components are produced manually below, but can also be added via plugins using the hooks provided:
 *
 * Templates::Article::Main
 * Templates::Article::Details
 * Templates::Article::Footer::PageFooter
 *
 * @uses $article Article This article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $primaryGalleys array List of article galleys that are not supplementary or dependent
 * @uses $supplementaryGalleys array List of article galleys that are supplementary
 * @uses $keywords array List of keywords assigned to this article
 * @uses $pubIdPlugins Array of pubId plugins which this article may be assigned
 * @uses $licenseTerms string License terms.
 * @uses $copyrightHolder string Name of copyright holder
 * @uses $copyrightYear string Year of copyright
 * @uses $licenseUrl string URL to license. Only assigned if license should be included with published submissions.
 * @uses $ccLicenseBadge string An image and text with details about the license
 *}
{* DOI (requires plugin) *}
{foreach from=$pubIdPlugins item=pubIdPlugin}
    {if $pubIdPlugin->getPubIdType() == 'doi'}
        {if $issue->getPublished()}
            {assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
        {else}
            {assign var=pubId value=$pubIdPlugin->getPubId($article)}{* Preview pubId *}
        {/if}
    {/if}
{/foreach}
{if $pubId}
    {assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
{/if}
<article class="article-details-tpl" id="article-abstract-view" {if $article}data-article="{$article->getBestArticleId()}"{/if}>
    <div class="row mt-4">
        <div class="col mb-4">
            <header class="article-details-header mb-3 border-bottom">
                <h1>
                    {$article->getLocalizedTitle($article->getLocale())|escape}
                </h1>
                {if sizeof($currentJournal->getSupportedLocaleNames())>1}
                    {foreach from=$currentJournal->getSupportedLocaleNames() item=itm key=localekey}
                        {if $localekey != $article->getLocale() && $article->getLocalizedTitle($localekey)}
                            <h2 class="text-muted">{$article->getLocalizedTitle($localekey)|escape}</h2>
                        {/if}
                    {/foreach}
                {/if}
                {if $article->getLocalizedSubtitle($article->getLocale())}
                    <h3 class="text-muted">{$article->getLocalizedSubtitle($article->getLocale())|escape}</h3>
                {/if}
            </header>
            <section aria-label="{translate key="plugins.themes.psychOpen.aria.article.main"}">
                {if $article->getAuthors()}
                    <h2 class="sr-only">{translate key="plugins.themes.psychOpen.aria.authors"}</h2>
                    <ul class="article-details-authors list-group list-group-no-border mb-3">
                        {foreach from=$article->getAuthors() item=author}
                            <li class="list-group-item mb-2">
                                <strong>{$author->getFullName()|escape}</strong>
                                {if $author->getOrcid()}
                                    <a href="{$author->getOrcid()|escape}" target="_blank" rel="noreferrer" class="ml-1">
                                        <img style="max-height: 18px; position: relative; top: -2px" src="{$imageURL}ORCID-icon.png" alt="Orcid">
                                    </a>
                                {/if}
                                {if $author->getLocalizedAffiliation()}
                                    <div class="article-author-affilitation">
                                        {$author->getLocalizedAffiliation()|escape}
                                    </div>
                                {/if}
                                {*{if $author->getOrcid()}
                                    <div class="orcid-lol">
                                        <img style="max-height: 18px; position: relative; top: -2px" src="{$imageURL}ORCID-icon.png" alt="Open Access">
                                        <a href="{$author->getOrcid()|escape}" target="_blank">
                                            {$author->getOrcid()|escape}
                                        </a>
                                    </div>
                                {/if}*}
                            </li>
                        {/foreach}
                    </ul>
                {/if}
                {* Article abstract *}
                {if $article->getLocalizedAbstract()}
                    <div class="article-details-summary row mb-2" id="summary">
                        <div class="article-abstract font-layout col-12">
                            <h3 class="border-bottom mb-2">{translate key="plugins.themes.psychOpen.article.details.abstract"}</h3>
                            {* TODO cover set to false *}
                            {if $article->getLocalizedCoverImage() && false}
                                <img class="article-abstract-img float-right ml-3" style="max-width: 200px;"
                                     src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText()} alt="{$article->getLocalizedCoverImageAltText()|escape}"{/if}>
                            {/if}
                            {$article->getLocalizedAbstract()|strip_unsafe_html|nl2br}
                        </div>
                    </div>
                {/if}
                {* Article Subject *}
                {if $article->getLocalizedSubject()}
                    <div class="row">
                        <div class="col-12">
                            <h2>{translate key="article.subject"}</h2>
                        </div>
                        <div class="col-12">
                            {$article->getLocalizedSubject()|escape}
                        </div>
                    </div>
                {/if}
                {* Author biographies *}
                {assign var="hasBiographies" value=0}
                {foreach from=$article->getAuthors() item=author}
                    {if $author->getLocalizedBiography()}
                        {assign var="hasBiographies" value=$hasBiographies+1}
                    {/if}
                {/foreach}
                {if $hasBiographies}
                    <div class="row">
                        <div class="col-12">
                            <h2>
                                {if $hasBiographies > 1}
                                    {translate key="submission.authorBiographies"}
                                {else}
                                    {translate key="submission.authorBiography"}
                                {/if}
                            </h2>
                        </div>
                        <div class="col-12">
                            {foreach from=$article->getAuthors() item=author}
                                {if $author->getLocalizedBiography()}
                                    <div class="sub_item">
                                        <div class="label">
                                            {if $author->getLocalizedAffiliation()}
                                                {capture assign="authorName"}{$author->getFullName()|escape}{/capture}
                                                {capture assign="authorAffiliation"}<span
                                                        class="affiliation">{$author->getLocalizedAffiliation()|escape}</span>{/capture}
                                                {translate key="submission.authorWithAffiliation" name=$authorName affiliation=$authorAffiliation}
                                            {else}
                                                {$author->getFullName()|escape}
                                            {/if}
                                        </div>
                                        <div class="value">
                                            {$author->getLocalizedBiography()|strip_unsafe_html}
                                        </div>
                                    </div>
                                {/if}
                            {/foreach}
                        </div>
                    </div>
                {/if}
                {call_hook name="Templates::Article::Footer::PageFooter"}
            </section>
        </div>
        <aside class="col-12 col-xl-4 mb-5" aria-label="{translate key="plugins.themes.psychOpen.aria.article.sidebar"}">
            {if $article && $article->getGalleys()}
                {foreach from=$article->getGalleys() item=galley}
                    {if "XML" == $galley->getLabel()}
                        {assign var="apatitle" value={loadDataFromXML locale=$article->getLocale() xmlUri={url page="article" op="download" path=$article->getBestArticleId()|to_array:$galley->getBestGalleyId($currentJournal)}}}
                    {/if}
                {/foreach}
            {/if}            {* Article cover image *}
            {*{if $article->getLocalizedCoverImage() }
                <img class="img-responsive"
                     src="{$article->getLocalizedCoverImageUrl()|escape}"{if $article->getLocalizedCoverImageAltText()} alt="{$article->getLocalizedCoverImageAltText()|escape}"{/if}>
            {/if}*}
            {* Article Galleys *}
            {if $primaryGalleys || $supplementaryGalleys}
                <div class="btn-group d-flex mb-4" role="group" aria-label="{translate key="plugins.themes.psychOpen.aria.article.sidebar.download"}">
                    {if $primaryGalleys}
                        {foreach from=$primaryGalleys item=galley}
                            {if $galley->getLabel()|escape == "PDF" || $galley->getLabel()|escape == "HTML" || $galley->getLabel()|escape == "XML"}
                                {include file="frontend/objects/galley_link.tpl" custom_classes="btn btn-secondary btn-download"
                                parent=$article purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
                            {/if}
                        {/foreach}
                    {/if}
                    {if $supplementaryGalleys}
                        {foreach from=$supplementaryGalleys item=galley}
                            {include file="frontend/objects/galley_link.tpl" custom_classes="btn btn-secondary btn-download" parent=$article isSupplementary="1"}
                        {/foreach}
                    {/if}
                </div>
            {/if}
            {* tab menu *}
            <ul class="nav nav-tabs mb-3 mt-3 nav-fill" id="article-tabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="article-meta-tab" data-toggle="tab" href="#article-meta" role="tab" aria-controls="article-meta"
                       aria-selected="true">
                        Article info
                    </a>
                </li>
                {if $suppList}
                    <li class="nav-item">
                        <a class="nav-link" id="supp-tab" data-toggle="tab" href="#supp" role="tab" aria-controls="supp" aria-selected="false">
                            Supplementary Files
                        </a>
                    </li>
                {/if}
                <li class="nav-item">
                    <a class="nav-link" id="impact-tab" data-toggle="tab" href="#impact" role="tab" aria-controls="impact" aria-selected="false">
                        {translate key="plugins.themes.psychOpen.impact"}
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="cited-by-tab" data-toggle="tab" href="#cited-by" role="tab" aria-controls="cited-by" aria-selected="false">
                        {translate key="plugins.themes.psychOpen.citations"}
                    </a>
                </li>

                {if $citation || $citeList}
                    <li class="nav-item">
                        <a class="nav-link" id="article-cite-tab" data-toggle="tab" href="#article-cite" role="tab" aria-controls="article-cite"
                           aria-selected="true">
                            {translate key="submission.howToCite"}
                        </a>
                    </li>
                {/if}
                {if $copyright || $licenseUrl}
                    <li class="nav-item">
                        <a class="nav-link" id="license-tab" data-toggle="tab" href="#license" role="tab" aria-controls="license" aria-selected="false">
                            {translate key="submission.license"}
                        </a>
                    </li>
                {/if}
            </ul>
            <div class="tab-content mb-5" id="myTabContent">
                <div class="tab-pane fade show active" id="article-meta" role="tabpanel" aria-labelledby="article-meta-tab">
                    <ul class="list-group list-group-flush">
                        {* Published date *}
                        {if $article->getDatePublished()}
                            <li class="list-group-item">
                                <div class="row">
                                    <div class="col-1">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span class="sr-only">{translate key="plugins.themes.psychOpen.aria.article.published"}</span>
                                    </div>
                                    <div class="col">{$article->getDatePublished()|date_format:"%e. %B %Y"}</div>
                                </div>
                            </li>
                        {/if}
                        {* DOI *}
                        {if $pubId}
                            {assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
                            <li class="list-group-item">
                                <div class="row">
                                    <div class="col-1">
                                        <i class="fas fa-external-link-alt"></i>
                                    </div>
                                    <div class="col">
                                        <a href="{$doiUrl}" aria-label="{translate key="plugins.themes.psychOpen.aria.article.doi"}">
                                            {$doiUrl}
                                        </a>
                                    </div>
                                </div>
                            </li>
                        {/if}
                        {* Issue article appears in *}
                        <li class="list-group-item">
                            <div class="row mb-1">
                                <div class="col-12">
                                    <strong>{translate key="issue.issue"}:</strong>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <a class="title" href="{url page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}">
                                        {$issue->getIssueIdentification()}
                                    </a>
                                </div>
                            </div>
                        </li>
                        {* SECTION *}
                        {if $section}
                            <li class="list-group-item">
                                <div class="row mb-1">
                                    <div class="col-12">
                                        <strong>{translate key="section.section"}:</strong>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        {$section->getLocalizedTitle()|escape}
                                    </div>
                                </div>
                            </li>
                        {/if}
                        {* CATEGORY *}
                        {assign var="catLoaded" value={loadCategoryBySubmission submissionId=$article->getId()}}
                        {if $catLoaded}
                            <li class="list-group-item">
                                <div class="row mb-1">
                                    <div class="col-12">
                                        <strong>Kategorien:</strong>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        {foreach from=$articleCat item=category}
                                            <a href="{url page="catalog" op="category" path=$category->getPath()}"><span
                                                        class="badge badge-dark">{$category->getLocalizedTitle()}</span></a>
                                        {/foreach}
                                    </div>
                                </div>
                            </li>
                        {/if}
                        {* Keywords *}
                        {if !empty($keywords[$currentLocale])}
                            <li class="list-group-item">
                                <div class="row mb-1">
                                    <div class="col-12">
                                        <strong>{translate key="article.subject"}:</strong>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        {foreach from=$keywords item=keyword}
                                            {foreach name=keywords from=$keyword item=keywordItem}
                                                <span class="badge badge-light">{$keywordItem|escape}</span>
                                            {/foreach}
                                        {/foreach}
                                    </div>
                                </div>

                            </li>
                        {/if}
                        {* References *}
                        {if $article->getCitations()}
                            <li class="list-group-item">
                                <div class="row">
                                    <div class="col-12">
                                        <strong>{translate key="submission.citations"}:</strong>
                                    </div>
                                    <div class="col-12">
                                        {$article->getCitations()|nl2br}
                                    </div>
                                </div>
                            </li>
                        {/if}
                        {* Social Icons *}
                        <li class="list-group-item">
                            <div class="row">
                                <div class="col-12 mb-1">
                                    <strong>Share:</strong>
                                </div>
                                <div class="col-12">
                                    {assign var="currentURI" value=$doiUrl}
                                    {capture name="title"}{$article->getLocalizedTitle($article->getLocale())|escape} %7C {$siteTitle}{/capture}
                                    {include file="frontend/components/social_share.tpl" url=$currentURI title=$smarty.capture.title}
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                {* How to cite tab*}
                {if $citation || $citeList}
                    <div class="tab-pane fade" id="article-cite" role="tabpanel" aria-labelledby="article-cite-tab">
                        {if !$citation && $citeList}
                            <div class="row mb-2 article-details-cite">
                                <div class="col-12">
                                    <ul class="list-group list-group-flush">
                                        {foreach $citeList as $p}
                                            <li class="list-group-item copy_to_clip_li">
                                                {*<strong>{$p@key}:</strong>*}
                                                <button class="copy_to_clip_btn btn btn-sm btn-secondary"
                                                        style="position: absolute; top: 0;right: 0; display: none">
                                                    <i class="fas fa-copy"></i>
                                                </button>
                                                <div class="copy_to_clip_txt">{$p}</div>
                                            </li>
                                        {/foreach}
                                    </ul>
                                </div>
                            </div>
                            {*{call_hook name="Templates::Article::Cite::Export"}*}
                        {else}
                            <div class="row mb-2 article-details-cite">
                                <div class="col-12">
                                    <div class="border-bottom mb-2" id="citationOutput" role="region" aria-live="polite">
                                        {$citation}
                                    </div>
                                    <div class="dropdown">
                                        <button id="dropdownCite" type="button" class="btn btn-download btn-sm btn-block dropdown-toggle" data-toggle="dropdown"
                                                aria-haspopup="true"
                                                aria-expanded="false">
                                            {translate key="submission.howToCite.citationFormats"}
                                        </button>
                                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownCite">
                                            {foreach from=$citationStyles item="citationStyle"}
                                                <a
                                                        rel="nofollow"
                                                        class="dropdown-item"
                                                        target="_blank"
                                                        aria-controls="citationOutput"
                                                        href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgs}"
                                                        data-load-citation
                                                        data-json-href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgsJson}"
                                                >
                                                    {$citationStyle.title|escape}
                                                </a>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 mt-3">
                                    {if count($citationDownloads)}
                                        <div>{translate key="submission.howToCite.downloadCitation"}</div>
                                        <ul class="list-group list-group-flush">
                                            {foreach from=$citationDownloads item="citationDownload"}
                                                <li class="list-group-item">
                                                    <a rel="nofollow"
                                                       href="{url page="citationstylelanguage" op="download" path=$citationDownload.id params=$citationArgs}">
                                                        <span class="fa fa-download"></span>
                                                        {$citationDownload.title|escape}
                                                    </a>
                                                </li>
                                            {/foreach}
                                        </ul>
                                    {/if}
                                </div>
                            </div>
                        {/if}
                    </div>
                {/if}
                {* cited-by tab*}
                <div class="tab-pane fade" id="cited-by" role="tabpanel" aria-labelledby="cited-by-tab">
                    {call_hook name="Templates::Article::Details"}
                </div>
                {* copyright tab *}
                {if $copyright || $licenseUrl}
                    <div class="tab-pane fade" id="license" role="tabpanel" aria-labelledby="license-tab">
                        {if $licenseUrl}
                            {if $licenseUrl|strstr:"creativecommons.org"}
                                {assign var="myArray" value=$licenseUrl|explode:"/"}
                                <div class="row">
                                    <div class="col text-center">
                                        <img class="mt-2 mb-2" src="https://licensebuttons.net/l/{$myArray[4]}/{$myArray[5]}/88x31.png"
                                             alt="CC {$myArray[4]} {$myArray[5]} License"/>
                                    </div>
                                </div>
                                This work is licensed under a
                                <a href="{$licenseUrl|escape}">
                                    Creative Commons
                                    {if $licenseUrl|strstr:"/by-sa/"}
                                        Attribution ShareAlike (CC BY-SA)
                                    {elseif $licenseUrl|strstr:"/by-nd/"}
                                        Attribution-NoDerivs (CC BY-ND)
                                    {elseif $licenseUrl|strstr:"/by-nc/"}
                                        Attribution-NonCommercial (CC BY-NC)
                                    {elseif $licenseUrl|strstr:"/by-nc-sa/"}
                                        Attribution-NonCommercial-ShareAlike (CC BY-NC-SA)
                                    {elseif $licenseUrl|strstr:"/by-nc-nd/"}
                                        Attribution-NonCommercial-NoDerivs (CC BY-NC-ND)
                                    {elseif $licenseUrl|strstr:"/by/"}
                                        Attribution (CC BY)
                                    {/if}
                                    {$myArray[5]} International License.
                                </a>
                            {else}
                                <a href="{$licenseUrl|escape}">
                                    {if $copyrightHolder}
                                        {translate key="submission.copyrightStatement" copyrightHolder=$copyrightHolder copyrightYear=$copyrightYear}
                                    {else}
                                        {translate key="submission.license"}
                                    {/if}
                                </a>
                            {/if}
                            {*{if $ccLicenseBadge}
                                {$ccLicenseBadge}
                            {/if}*}
                        {elseif $copyright}
                            {$copyright}
                        {/if}
                    </div>
                {/if}
                <div class="tab-pane fade" id="impact" role="tabpanel" aria-labelledby="impact-tab">
                    {* GALLEYS *}
                    {assign var=galleys value=$article->getGalleys()}
                    <ul class="list-group list-group-flush">
                        {* altmetric *}
                        {if $pubId}
                            <li class="list-group-item">
                                <div class="row text-center mb-2 mt-3">
                                    {*<div class="col-4">
                                        <strong>{translate key="plugins.themes.psychOpen.article.details.altmetric"}</strong>
                                    </div>*}
                                    <div class="col-6">
                                        <strong>{translate key="plugins.themes.psychOpen.article.details.plumx"}</strong>
                                    </div>
                                    <div class="col-6">
                                        <strong>{translate key="plugins.themes.psychOpen.article.details.dimensions"}</strong>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    {*<div class="col-4 text-center">
                                        <div data-badge-popover="top" data-badge-type="medium-donut" data-link-target="_blank" data-doi="{$pubId}" class="altmetric-embed"></div>
                                    </div>*}
                                    <div class="col-6 text-center">
                                        <a href="https://plu.mx/plum/a/?doi={$pubId}" data-popup="top" data-size="large" class="plumx-plum-print-popup"
                                           data-site="plum"></a>
                                        <script async type="text/javascript" src="//cdn.plu.mx/widget-popup.js"></script>
                                    </div>
                                    <div class="col-6 text-center">
                                        <div class="__dimensions_badge_embed__ text-center" data-doi="{$pubId}" data-legend="hover-top"></div>
	                                    <script async src="https://badge.dimensions.ai/badge.js" charset="utf-8"></script>
                                    </div>
                                </div>
                            </li>
                            {*<li class="list-group-item">
                                <a href="https://plu.mx/plum/a/?doi={$pubId}" class="plumx-summary"></a>
                                <script type="text/javascript" src="//cdn.plu.mx/widget-summary.js"></script>
                            </li>*}
                        {/if}
                        {if $galleys}
                            <li class="list-group-item">
                                {assign var="abstractViews" value={getAbstractViews fileId=$article->getId()}}
                                {assign var="galleysTotalView" value=$abstractViews}
                                {foreach from=$galleys item=galley name=galleyList}
                                    {*        {$galley->getGalleyLabel()}: {$galley->getViews()} views. *}
                                    {assign var="galleysTotalView" value=$galleysTotalView+$galley->getViews()}
                                {/foreach}
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <strong>{translate key="plugins.themes.psychOpen.article.views"}:</strong>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-12">
                                        <table class="table table-borderless table-sm text-center" style="margin: 0">
                                            <tr class="text-nowrap text-truncate">
                                                <th>{translate key="plugins.themes.psychOpen.article.views.total"}</th>
                                                <th>{translate key="plugins.themes.psychOpen.article.details.abstract"}</th>
                                                {foreach from=$galleys item=galley name=galleyList}
                                                    {if $galley->getLabel()|escape|upper == "PDF" || $galley->getLabel()|escape|upper == "HTML" || $galley->getLabel()|escape|upper == "XML"}
                                                        <th>{$galley->getLabel()}</th>
                                                    {/if}
                                                {/foreach}
                                            </tr>
                                            <tr>
                                                <td>{$galleysTotalView}</td>
                                                <td>{$abstractViews}</td>
                                                {foreach from=$galleys item=galley name=galleyList}
                                                    {if $galley->getLabel()|escape|upper == "PDF" || $galley->getLabel()|escape|upper == "HTML" || $galley->getLabel()|escape|upper == "XML"}
                                                        <td>{$galley->getViews()}</td>
                                                    {/if}
                                                {/foreach}
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </li>
                        {/if}
                        {call_hook name="Templates::Article::Main"}
                    </ul>
                </div>
                <div class="tab-pane fade" id="supp" role="tabpanel" aria-labelledby="supp-tab">
                    <ul class="list-group list-group-flush">
                        {if $suppList}
                            {foreach from=$suppList item=supp}
                                <li class="list-group-item">
                                    <strong>{$supp['authors']}</strong> ({$supp['year']}). <i>{$supp['title']}</i>,
                                    {if $supp['pub-id']}
                                        {if $supp['pub-id-type'] == 'doi'}
                                            <a href="https://doi.org/{$supp['pub-id']}" target="_blank" rel="noreferrer"
                                               onclick="pushGoal('Supplements', '{$supp['pub-id']}', 1);">{$supp['pub-id']}</a>
                                        {/if}
                                    {elseif $supp['ext-link']}
                                        <a href="{$supp['ext-link']}" target="_blank" rel="noreferrer"
                                           onclick="pushGoal('Supplements', '{$supp['ext-link']}', 1);">{$supp['ext-link']}</a>
                                    {/if}
                                </li>
                            {/foreach}
                        {/if}
                    </ul>
                </div>

            </div>
        </aside><!-- .article-sidebar -->
    </div><!-- .row -->

</article>
