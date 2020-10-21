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
			{assign var=pubId value=$pubIdPlugin->getPubId($publication)}{* Preview pubId *}
		{/if}
	{/if}
{/foreach}
{if $pubId}
	{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
{/if}
<article class="article-details-tpl">
	<div class="row mt-4">
		<div class="col mb-4">
			<header class="article-details-header mb-3 border-bottom">
				{* Notification that this is an old version *}
				{if $currentPublication->getId() !== $publication->getId()}
					<div class="alert alert-info">
						{capture assign="latestVersionUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}
						{translate key="submission.outdatedVersion"
						datePublished=$publication->getData('datePublished')|date_format:$dateFormatShort
						urlRecentVersion=$latestVersionUrl|escape
						}
					</div>
				{/if}
				<h1>
					{$publication->getLocalizedTitle($publication->getData('locale'))|escape}
				</h1>
				{if sizeof($currentJournal->getSupportedLocaleNames())>1}
					{foreach from=$currentJournal->getSupportedLocaleNames() item=itm key=localekey}
						{if $localekey != $publication->getData('locale') && $publication->getLocalizedTitle($localekey)}
							<h2 class="text-muted">{$publication->getLocalizedTitle($localekey)|escape}</h2>
						{/if}
					{/foreach}
				{/if}
				{if $publication->getLocalizedData('subtitle')}
					<h3 class="text-muted">{$publication->getLocalizedData('subtitle')|escape}</h3>
				{/if}
			</header>
			<section aria-label="{translate key="plugins.themes.psychOpen.aria.article.main"}">
				{if $publication->getData('authors')}
					<h2 class="sr-only">{translate key="plugins.themes.psychOpen.aria.authors"}</h2>
					<ul class="article-details-authors list-group list-group-no-border mb-3">
						{foreach from=$publication->getData('authors') item=author}
							<li class="list-group-item mb-2">
								<strong>{$author->getFullName()|escape}</strong>
								{if $author->getData('orcid')}
									<a href="{$author->getData('orcid')|escape}" target="_blank" rel="noreferrer" class="ml-1">
										<img style="max-height: 18px; position: relative; top: -2px" src="{$imageURL}ORCID-icon.png" alt="Orcid">
									</a>
								{/if}
								{if $author->getLocalizedData('affiliation')}
									<div class="article-author-affilitation">
										{$author->getLocalizedData('affiliation')|escape}
									</div>
								{/if}
							</li>
						{/foreach}
					</ul>
				{/if}
				{* Article abstract *}
				{if $publication->getLocalizedData('abstract')}
					<div class="article-details-summary row mb-2" id="summary">
						<div class="article-abstract font-layout col-12">
							<h3 class="border-bottom mb-2">{translate key="plugins.themes.psychOpen.article.details.abstract"}</h3>
							{* TODO cover set to false *}
							{if $publication->getLocalizedData('coverImage') && false}
								<img class="article-abstract-img float-right ml-3" style="max-width: 200px;"
								     src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}"
								     alt="{$coverImage.altText|escape|default:''}">
							{/if}
							{$publication->getLocalizedData('abstract')|strip_unsafe_html|nl2br}
						</div>
					</div>
				{/if}
				{* Author biographies *}
				{assign var="hasBiographies" value=0}
				{foreach from=$publication->getData('authors') item=author}
					{if $author->getLocalizedData('biography')}
						{assign var="hasBiographies" value=$hasBiographies+1}
					{/if}
				{/foreach}
				{if $hasBiographies}
					<div class="article-details-summary row mb-2">
						<div class="col-12">
							<h3 class="border-bottom mb-2">
								{if $hasBiographies > 1}
									{translate key="submission.authorBiographies"}
								{else}
									{translate key="submission.authorBiography"}
								{/if}
							</h3>
						</div>
						<div class="article-abstract font-layout col-12">
							{foreach from=$publication->getData('authors') item=author}
								{if $author->getLocalizedData('biography')}
									<div class="sub_item">
										<div class="label">
											{if $author->getLocalizedData('affiliation')}
												{capture assign="authorName"}{$author->getFullName()|escape}{/capture}
												{capture assign="authorAffiliation"}<span
														class="affiliation">{$author->getLocalizedData('affiliation')|escape}</span>{/capture}
												{translate key="submission.authorWithAffiliation" name=$authorName affiliation=$authorAffiliation}
											{else}
												{$author->getFullName()|escape}
											{/if}
										</div>
										<div class="value">
											{$author->getLocalizedData('biography')|strip_unsafe_html}
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
			{if $publication && $publication->getData('galleys')}
				{foreach from=$publication->getData('galleys') item=galley}
					{if "XML" == $galley->getLabel()}
						{assign var="apatitle" value={loadDataFromXML locale=$publication->getData('locale') xmlUri={url page="article" op="download" path=$article->getBestArticleId()|to_array:$galley->getBestGalleyId($currentJournal)}}}
					{/if}
				{/foreach}
			{/if}
			{* Article Galleys *}
			{if $primaryGalleys || $supplementaryGalleys}
				<div class="btn-group d-flex mb-4" role="group" aria-label="{translate key="plugins.themes.psychOpen.aria.article.sidebar.download"}">
					{if $primaryGalleys}
						{foreach from=$primaryGalleys item=galley}
							{if $galley->getLabel()|escape == "PDF" || $galley->getLabel()|escape == "HTML" || $galley->getLabel()|escape == "XML"}
								{include file="frontend/objects/galley_link.tpl" custom_classes="btn btn-secondary btn-download"
								parent=$article publication=$publication galley=$galley purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
							{/if}
						{/foreach}
					{/if}
					{if $supplementaryGalleys}
						{foreach from=$supplementaryGalleys item=galley}
							{include file="frontend/objects/galley_link.tpl" custom_classes="btn btn-secondary btn-download" parent=$article publication=$publication galley=$galley isSupplementary="1"}
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
				<li class="nav-item">
					<a class="nav-link" id="license-tab" data-toggle="tab" href="#license" role="tab" aria-controls="license" aria-selected="false">
						{translate key="submission.license"}
					</a>
				</li>
			</ul>
			<div class="tab-content mb-5" id="myTabContent">
				<div class="tab-pane fade show active" id="article-meta" role="tabpanel" aria-labelledby="article-meta-tab">
					<ul class="list-group list-group-flush">
						{* Published date *}
						{if $publication->getData('datePublished')}
							<li class="list-group-item">
								<div class="row">
									<div class="col-1">
										<i class="fas fa-calendar-alt"></i>
										<span class="sr-only">{translate key="plugins.themes.psychOpen.aria.article.published"}</span>
									</div>
									<div class="col">
										{* If this is the original version *}
										{if $firstPublication->getID() === $publication->getId()}
											<span>{$firstPublication->getData('datePublished')|date_format:"%e. %B %Y"}</span>
											{* If this is an updated version *}
										{else}
											<span>{translate key="submission.updatedOn" datePublished=$firstPublication->getData('datePublished')|date_format:"%e. %B %Y" dateUpdated=$publication->getData('datePublished')|date_format:"%e. %B %Y"}</span>
										{/if}
									</div>
								</div>
							</li>
						{/if}
						{if count($article->getPublishedPublications()) > 1}
							<li class="list-group-item">
								<div class="row mb-1">
									<div class="col-12">
										<strong>{translate key="submission.versions"}:</strong>
									</div>
								</div>
								<div class="row">
									<div class="col-12">
										{foreach from=array_reverse($article->getPublishedPublications()) item=iPublication}
											{capture assign="name"}{translate key="submission.versionIdentity" datePublished=$iPublication->getData('datePublished')|date_format:$dateFormatShort version=$iPublication->getData('version')}{/capture}
											<div>
												{if $iPublication->getId() === $publication->getId()}
													{$name}
												{elseif $iPublication->getId() === $currentPublication->getId()}
													<a href="{url page="article" op="view" path=$article->getBestId()}">{$name}</a>
												{else}
													<a href="{url page="article" op="view" path=$article->getBestId()|to_array:"version":$iPublication->getId()}">{$name}</a>
												{/if}
											</div>
										{/foreach}
									</div>
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
						{assign var="catLoaded" value={loadCategoryBySubmission submissionId=$publication->getId()}}
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
						{if !empty($publication->getLocalizedData('keywords'))}
							<li class="list-group-item">
								<div class="row mb-1">
									<div class="col-12">
										<strong>
											{capture assign=translatedKeywords}{translate key="article.subject"}{/capture}
											{translate key="semicolon" label=$translatedKeywords}
										</strong>
									</div>
								</div>
								<div class="row">
									<div class="col-12">
										{foreach name="keywords" from=$publication->getLocalizedData('keywords') item="keyword"}
											<span class="badge badge-light">{$keyword|escape}</span>
										{/foreach}
									</div>
								</div>
							</li>
						{/if}
						{* References *}
						{if $parsedCitations || $publication->getData('citationsRaw')}
							<li class="list-group-item">
								<div class="row">
									<div class="col-12">
										<strong>{translate key="submission.citations"}:</strong>
									</div>
									<div class="col-12">
										{if $parsedCitations}
											{foreach from=$parsedCitations item="parsedCitation"}
												<p>{$parsedCitation->getCitationWithLinks()|strip_unsafe_html} {call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}</p>
											{/foreach}
										{else}
											{$publication->getData('citationsRaw')|escape|nl2br}
										{/if}
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
									{capture name="title"}{$publication->getLocalizedTitle($publication->getData('locale'))} | {$siteTitle}{/capture}
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
					{else}
						{translate key="submission.copyrightStatement" copyrightHolder=$copyrightHolder[$publication->getData('locale')] copyrightYear=$copyrightYear}
					{/if}
				</div>
				<div class="tab-pane fade" id="impact" role="tabpanel" aria-labelledby="impact-tab">
					{* GALLEYS *}
					{assign var=galleys value=$publication->getData('galleys')}
					<ul class="list-group list-group-flush">
						{* altmetric *}
						{if $pubId}
							<li class="list-group-item">
								<div class="row text-center mb-2 mt-3">
									<div class="col-6">
										<strong>{translate key="plugins.themes.psychOpen.article.details.plumx"}</strong>
									</div>
									<div class="col-6">
										<strong>{translate key="plugins.themes.psychOpen.article.details.dimensions"}</strong>
									</div>
								</div>
								<div class="row mb-3">
									<div class="col-6 text-center">
										<a href="https://plu.mx/plum/a/?doi={$pubId}" data-popup="top" data-size="large" class="plumx-plum-print-popup"
										   data-site="plum"></a>
										<script type="text/javascript" src="//cdn.plu.mx/widget-popup.js"></script>
									</div>
									<div class="col-6 text-center">
										<div class="__dimensions_badge_embed__ text-center" data-doi="{$pubId}" data-legend="hover-top"></div>
									</div>
								</div>
							</li>
						{/if}
						{if $galleys}
							<li class="list-group-item">
								{assign var="abstractViews" value={getAbstractViews fileId=$publication->getId()}}
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
