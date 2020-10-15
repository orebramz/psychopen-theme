{**
 * templates/frontend/pages/issue.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a landing page for a single issue. It will show the table of contents
 *  (toc) or a cover image, with a click through to the toc.
 *
 * @uses $issue Issue The issue
 * @uses $issueIdentification string Label for this issue, consisting of one or
 *       more of the volume, number, year and title, depending on settings
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $showGalleyLinks bool Show galley links to users without access?
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$issueIdentification}

<div id="main-content">
	{* Display a message if no current issue exists *}
	{if !$issue}
		{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="current.noCurrentIssue" breadcrumbtype="issue"}
		{include file="frontend/components/notification.tpl" type="alert-warning" messageKey="current.noCurrentIssueDesc"}

	{* Display an issue with the Table of Contents *}
	{else}
		{include file="frontend/components/breadcrumbs.tpl" currentTitle=$issueIdentification breadcrumbtype="issue"}
		{include file="frontend/objects/issue_toc.tpl"}
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
