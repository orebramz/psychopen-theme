{**
 * templates/frontend/components/breadcrumbs.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)

 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a breadcrumb nav item showing the current page.
 *
 * @uses $currentTitle string The title to use for the current page.
 * @uses $currentTitleKey string Translation key for title of current page.
 * @uses $issue Issue Issue this article was published in.
 *}

<nav aria-label="{translate key="navigation.breadcrumbLabel"}">
    <ol class="breadcrumb flex-nowrap text-nowrap">
        <li class="breadcrumb-item">
            <a href="{url page="index" router=$smarty.const.ROUTE_PAGE}">
                {translate key="common.homepageNavigationLabel"}
            </a>
        </li>
        {if $breadcrumbtype=="announcement"}
            <li class="breadcrumb-item">
                <a href="{url router=$smarty.const.ROUTE_PAGE page="announcement"}">
                    {translate key="announcement.announcements"}
                </a>
            </li>
        {elseif $breadcrumbtype=="issue"}
            <li class="breadcrumb-item">
                <a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}">
                    {translate key="navigation.archives"}
                </a>
            </li>
        {elseif $breadcrumbtype=="article"}
            <li class="breadcrumb-item">
                <a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}">
                    {translate key="navigation.archives"}
                </a>
            </li>
            <li class="breadcrumb-item">
                <a href="{url page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}">
                    {*<span itemprop="name">{translate key="issue.volume"} {$issue->getVolume()} [{translate key="issue.number"} {$issue->getNumber()}]</span>*}
                    {translate key="issue.volume"} {$issue->getVolume()} {if $issue->getNumber()}({$issue->getNumber()}){/if}
                </a>
            </li>
        {elseif $breadcrumbtype=="authorIndex"}
            <li class="breadcrumb-item">
                <a href="{url router=$smarty.const.ROUTE_PAGE page="search" op="search"}">
                    {translate key="common.search"}
                </a>
            </li>
        {elseif $breadcrumbtype=="authorIndexDetails"}
            <li class="breadcrumb-item">
                <a href="{url router=$smarty.const.ROUTE_PAGE page="search" op="search"}">
                    {translate key="common.search"}
                </a>
            </li>
            <li class="breadcrumb-item">
                <a href="{url router=$smarty.const.ROUTE_PAGE page="search" op="authors"}">
                    {translate key="search.authorIndex"}
                </a>
            </li>
        {/if}
        <li class="breadcrumb-item active text-truncate">
            <a href="{$smarty.server.SERVER_NAME}{$smarty.server.REQUEST_URI}" class="disabled" onclick="return false;">
                {if $currentTitleKey}{translate key=$currentTitleKey}{else}{$currentTitle|escape}{/if}
            </a>
        </li>
    </ol>
</nav>
