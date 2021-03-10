{include file="frontend/components/header.tpl" pageTitleTranslated=$issueIdentification}
<div class="page page_aam" id="main-content">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="plugins.generic.aam.breadcrumb"}
	<h1 class="mt-5">{translate key="plugins.generic.aam.headline"}</h1>
	{if empty($aamItems)}
		{include file="frontend/components/notification.tpl" type="warning" messageKey="plugins.generic.aam.help.no.content"}
	{else}
		<div class="mb-4 mt-4 alert alert-info">
			{translate key="plugins.generic.aam.help.content" journalName=$displayPageHeaderTitle|escape}
		</div>
		<ul class="mb-5 list-group list-group-flush">
			{foreach from=$aamItems item=aamItem}
				<li class="list-group-item">
					<div class="article-sum row">
						<div class="col-12">
							<h2>
								{$aamItem['title']|escape}
							</h2>
							<div class="meta">
								<div class="authors">
									{$aamItem['authors']|escape}
								</div>
							</div>
						</div>
						<div class="col-12">
							{if isset($aamItem['preliminaryDOI']) && !empty($aamItem['preliminaryDOI'])}
								<div class="pa-link-query" data-url="{url page="aam" op="getPsychArchivesLink"}"
								     data-doi="{$aamItem['preliminaryDOI']}">
									<div class="pa-link-query-result" style="display: none">
										<i class="fas fa-external-link-alt"></i>&nbsp;<a class="" href="" target="_blank"
										   rel="noreferrer"
										   aria-label="{translate key="plugins.generic.aam.link.pa"}">
											{translate key="plugins.generic.aam.link.pa"}
										</a>
									</div>
									<div class="pa-link-query-no-result" style="display: none">
										Author Accepted Manuscript not available (<a href="#" data-toggle="tooltip" onclick="return false"
										                  title="The authors have not yet published their AAM version with <a href='https://www.psycharchives.org' target='_blank'>PsychArchives</a>.">
											Why?</a> )
									</div>
								</div>
							{/if}
						</div>
					</div>
				</li>
			{/foreach}
		</ul>
	{/if}
	<script>


	</script>
	{*{url page="aam"}*}
</div>
{include file="frontend/components/footer.tpl"}
