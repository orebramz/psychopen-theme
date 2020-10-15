{**
 * templates/frontend/pages/article.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view an article with all of it's details.
 *
 * @uses $article Article This article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $journal Journal The journal currently being viewed.
 * @uses $primaryGalleys array List of article galleys that are not supplementary or dependent
 * @uses $supplementaryGalleys array List of article galleys that are supplementary
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$article->getLocalizedTitle()|escape}

<div id="main-content">
	{if $article->getLocalizedTitle()}
		{include file="frontend/components/breadcrumbs.tpl" currentTitle=$article->getLocalizedTitle() breadcrumbtype="article"}
	{else}
		{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="article.article" breadcrumbtype="article"}
	{/if}

	{* Show article overview *}
	{include file="frontend/objects/article_details.tpl"}

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
