{**
 * templates/frontend/pages/issueArchive.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a list of recent issues.
 *
 * @uses $issues Array Collection of issues to display
 * @uses $prevPage int The previous page number
 * @uses $nextPage int The next page number
 * @uses $showingStart int The number of the first item on this page
 * @uses $showingEnd int The number of the last item on this page
 * @uses $total int Count of all published monographs
 *}
{capture assign="pageTitle"}
    {if $prevPage}
        {translate key="archive.archivesPageNumber" pageNumber=$prevPage+1}
    {else}
        {translate key="archive.archives"}
    {/if}
{/capture}
{include file="frontend/components/header.tpl" pageTitleTranslated=$pageTitle}
<div id="main-content">
    {include file="frontend/components/breadcrumbs.tpl" currentTitle=$pageTitle}
    <h1 class="sr-only">{translate key="archive.archives"}</h1>
    {* No issues have been published *}
    {if empty($issues) && empty($issues_full)}
        <div class="alert alert-info" role="alert">
            {translate key="current.noCurrentIssueDesc"}
        </div>
    {else}
        {* List issues *}
        {foreach from=$issues_full item="issue"}
            {if $issueViewType=='sortByYear'}
                {$mat[$issue->getYear()][$issue->getId()] = $issue}
            {elseif $issueViewType=='sortByVolume'}
                {$mat[$issue->getVolume()][$issue->getId()] = $issue}
            {/if}
        {/foreach}
        {if $issueViewType=='sortByYear' || $issueViewType=='sortByVolume'}
            {foreach from=$mat item="arr"}
                <div class="card mb-2 border-0" id="{$arr@key}">
                    <div class="card-body">
                        {if $issueViewType=='sortByVolume'}
                            <h1 class="card-title">{translate key="issue.volume"}&nbsp;{$arr@key}</h1>
                        {else}
                            <h1 class="card-title">{$arr@key}</h1>
                        {/if}
                        <div class="row">
                            {if sizeof($arr)==1}
                                {assign var="colSize" value='col'}
                            {else}
                                {assign var="colSize" value='col-12 col-xl-6'}
                            {/if}
                            {foreach from=$arr item="issue"}
                                <div class="{$colSize} mb-2">
                                    {include file="frontend/objects/issue_summary.tpl"}
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </div>
            {/foreach}
        {else}
            <div class="row">
                {assign var="lastYear" value=""}
                {foreach from=$issues_full item="issue"}
                    <div class="{if sizeof($issues_full)>2}col-12 col-xl-6{else}col{/if} mb-3">
                        {include file="frontend/objects/issue_summary.tpl"}
                    </div>
                {/foreach}
            </div>
            {if $prevPage > 1}
                {capture assign=prevUrl}{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive" path=$prevPage}{/capture}
            {elseif $prevPage === 1}
                {capture assign=prevUrl}{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}{/capture}
            {/if}
            {if $nextPage}
                {capture assign=nextUrl}{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive" path=$nextPage}{/capture}
            {/if}
            {include
            file="frontend/components/pagination.tpl"
            prevUrl=$prevUrl
            nextUrl=$nextUrl
            showingStart=$showingStart
            showingEnd=$showingEnd
            total=$total
            }
        {/if}
    {/if}
</div>

{include file="frontend/components/footer.tpl"}
