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
                        <div class="col">
                            <h2>
                                {$aamItem['title']|escape}
                            </h2>
                            <div class="meta">
                                <div class="authors">
                                    {$aamItem['authors']|escape}
                                </div>
                            </div>
                        </div>
                        {if isset($aamItem['preliminaryDOI']) && !empty($aamItem['preliminaryDOI'])}
                            <div class="col-auto pa-link-query" style="display: none" data-url="{url page="aam" op="getPsychArchivesLink"}" data-doi="{$aamItem['preliminaryDOI']}">
                                <div class="row article-footer-bar">
                                    <div class="col">
                                        <div class="btn-group btn-group-sm">
                                            <a class="btn btn-sm btn-outline-dark mt-lg-0 mt-3 galley-link" href="" target="_blank"
                                               rel="noreferrer"
                                               aria-label="{translate key="plugins.generic.aam.link.pa"}">
                                                {translate key="plugins.generic.aam.link.pa"}
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/if}
                    </div>
                </li>
            {/foreach}
        </ul>
    {/if}
    {*{url page="aam"}*}
</div>
{include file="frontend/components/footer.tpl"}
