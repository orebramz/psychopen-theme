{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the index page for a journal
 *
 * @uses $currentJournal Journal This journal
 * @uses $journalDescription string Journal description from HTML text editor
 * @uses $homepageImage object Image to be displayed on the homepage
 * @uses $additionalHomeContent string Arbitrary input from HTML text editor
 * @uses $announcements array List of announcements
 * @uses $numAnnouncementsHomepage int Number of announcements to display on the homepage
 * @uses $issue Issue Current issue
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}
<div id="main-content">
	{call_hook name="Templates::Index::journal"}
	{* HomePage Image *}
	{if $homepageImage}
		<figure class="homepage-image mb-4">
			<img class="img-responsive" src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImageAltText|escape}">
		</figure>
	{/if}
	{* Journal Description *}
	{if $journalDescriptionCustom}
		<section class="card mb-3 default-card-layout">
			<h2 class="sr-only">{translate key="about.description"}</h2>
			<div class="card-body">
				{$journalDescriptionCustom}
			</div>
		</section>
	{elseif journalDescription}
		<section class="card mb-3 default-card-layout">
			<h2 class="sr-only">{translate key="about.description"}</h2>
			<div class="card-body">
				{$journalDescription}
			</div>
		</section>
	{/if}
	{if $recentArticles}
		<section class="card mb-3 default-card-layout recent-articles">
			<div class="card-body">
				<div class="card-title">
					<h2>{translate key="plugins.themes.psychOpen.journal.recent.articles"}</h2>
				</div>
				<ul class="list-group list-group-flush">
					{foreach from=$recentArticles item=recentArticle}
						<li class="list-group-item">
							<div class="row">
								<div class="col text-truncate">
									<a href={url page="article" op="view" path=$recentArticle->getBestArticleId($currentJournal)}>
										{$recentArticle->getLocalizedTitle($recentArticle->getLocale())|strip_unsafe_html}
									</a>
									{if $recentArticle->getLocalizedSubtitle($recentArticle->getLocale())}
										<div>{$recentArticle->getLocalizedSubtitle($recentArticle->getLocale())|strip_unsafe_html}</div>
									{/if}
									<div class="font-italic">{$recentArticle->getAuthorString()}</div>
								</div>
								<div class="col-auto">
									<span class="badge">{$recentArticle->getDatePublished()|date_format:"%B %Y"}</span>
								</div>
							</div>
						</li>
					{/foreach}
				</ul>
			</div>
		</section>
	{/if}
	{* Latest issue *}
	{if $showLatestIssue=="true" && $issue}
		<section class="card mb-3 default-card-layout">
			<div class="card-body">
				<div class="card-title border-bottom">
					<h2>
						{if $issue->getLocalizedTitle()|strip_unsafe_html}
							{$issue->getLocalizedTitle()|strip_unsafe_html}&nbsp;[{$issue->getIssueSeries()}]
						{elseif $issue->getIssueSeries()}
							{$issue->getIssueSeries()}
						{else}
							{translate key="journal.currentIssue"}
						{/if}</h2>
				</div>
				{include file="frontend/objects/issue_toc.tpl" indexPage=true}
			</div>
		</section>
	{/if}
	{if $showLatestAnnouncements=="true" && $numAnnouncementsHomepage && $announcements|count}
		<section class="card mb-3 default-card-layout">
			<div class="card-body">
				{* Announcements *}
				<div class="card-title">
					<h2>{translate key="announcement.announcements"}</h2>
				</div>
				<ul class="list-group list-group-flush">
					{foreach name=announcements from=$announcements item=announcement}
						{if $smarty.foreach.announcements.iteration <= $numAnnouncementsHomepage}
							<li class="list-group-item">
								{include file="frontend/objects/announcement_summary.tpl" hideHTMLParagraph=true}
							</li>
						{/if}
					{/foreach}
				</ul>
			</div>
		</section>
	{/if}
	{* Additional Homepage Content *}
	{if $additionalHomeContent}
		<section class="card mb-3 default-card-layout">
			<div class="card-body">
				{$additionalHomeContent}
			</div>
		</section>
	{/if}
</div>
{include file="frontend/components/footer.tpl"}
