{**
 * templates/submission/form/step3.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 3 of author submission.
 *}
<script type="text/javascript">
	$(function() {ldelim}
		// Attach the JS form handler.
		$('#submitStep3Form').pkpHandler(
			'$.pkp.pages.submission.SubmissionStep3FormHandler',
			{ldelim}
				chaptersGridContainer: 'chaptersGridContainer',
				authorsGridContainer: 'authorsGridContainer',
			{rdelim});
	{rdelim});
</script>

<form class="pkp_form" id="submitStep3Form" method="post" action="{url op="saveStep" path=$submitStep}" context="{$currentContext->getId()}">
	{csrf}
	<input type="hidden" name="submissionId" value="{$submissionId|escape}" />
	{include file="controllers/notification/inPlaceNotification.tpl" notificationId="submitStep3FormNotification"}

	{include file="core:submission/submissionMetadataFormTitleFields.tpl"}

	{include file="submission/form/categories.tpl"}

	{include file="submission/submissionMetadataFormFieldsCopy.tpl"}
	
	{*Disable contributors panel for context=11 (Personality Science) *}
	{if $currentContext->getId() != 11 }
		{fbvFormArea id="contributors"}
			<!--  Contributors -->
			{capture assign=authorGridUrl}{url router=$smarty.const.ROUTE_COMPONENT component="grid.users.author.AuthorGridHandler" op="fetchGrid" submissionId=$submissionId escape=false}{/capture}
			{load_url_in_div id="authorsGridContainer" url=$authorGridUrl}

			{$additionalContributorsFields}
		{/fbvFormArea}
	{/if}

	{fbvFormButtons id="step3Buttons" submitText="common.saveAndContinue"}
</form>
