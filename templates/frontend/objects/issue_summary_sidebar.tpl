{**
 * templates/frontend/objects/issue_summary_sidebar.tpl
 *
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a summary for use in lists
 *
 * @uses $issue Issue The issue
 *}
<div>
    <div>
        {if $issueViewType=='sortByYear'}
            <a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}#{$issue->getYear()|escape}">
                {$issue->getYear()|escape}&nbsp;Volume&nbsp;{$issue->getVolume()|escape}
            </a>
        {elseif $issueViewType=='sortByVolume'}
            <a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}#{$issue->getVolume()|escape}">
                {translate key="issue.volume"}&nbsp;{$issue->getVolume()|escape}&nbsp;({$issue->getYear()|escape})
            </a>
        {else}
            <a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}">
                {$issue->getIssueSeries()|escape}&nbsp;{$issue->getLocalizedTitle()|escape}
            </a>
        {/if}
    </div>
</div><!-- .issue-summary -->
