{**
 * templates/frontend/pages/error.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2000-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Generic error page.
 * Displays a simple error message and (optionally) a return link.
 *}
{include file="frontend/components/header.tpl"}
<div id="main-content">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey=$pageTitle}
	<div class="mt-4 mb-4">
		{translate key=$errorMsg params=$errorParams}
	</div>
	{if $backLink}
		<div class="mb-5">
			<a href="{$backLink}">{translate key=$backLinkLabel}</a>
		</div>
	{/if}
</div>
{include file="frontend/components/footer.tpl"}
