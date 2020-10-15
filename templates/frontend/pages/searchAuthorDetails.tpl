{**
 * templates/frontend/pages/searchAuthorDetails.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Index of published submissions by author.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="search.authorDetails"}
<div id="main-content" class="search-tpl">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="search.authorDetails" breadcrumbtype="authorIndexDetails"}
    <h1 class="mb-3 mt-3">{$authorName|escape}{if $affiliation}, {$affiliation|escape}{/if}{if $country}, {$country|escape}{/if}</h1>
    {foreach from=$publishedArticles item=article}
        {assign var=issue value=$issues[$article->getIssueId()]}
        {if $issue && $issue->getPublished() && $journals[$article->getJournalId()]}
            {$mat[$article->getJournalId()][$issue->getIssueIdentification()|strip_unsafe_html|nl2br][$article->getId()] = $article}
            {$mat2[$article->getJournalId()][$issue->getIssueIdentification()|strip_unsafe_html|nl2br] = $issue->getBestIssueId()}
        {/if}
    {/foreach}

    {foreach from=$mat item="j"}
        {assign var=journal value=$journals[$j@key]}
        {assign var="sort" value=krsort($j)}
        {foreach from=$j item="i"}
            <div class="card mb-2">
                <div class="card-header"><a href="{url journal=$journal->getPath() page="issue" op="view" path=$mat2[$j@key][$i@key]}">
                        {$journal->getLocalizedName()|escape} - {$i@key}
                    </a></div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        {foreach from=$i item="article"}
                            {assign var=issue value=$issues[$article->getIssueId()]}
                            <li class="list-group-item">{include file="frontend/objects/article_summary.tpl" article=$article}</li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        {/foreach}
    {/foreach}


</div>
{include file="frontend/components/footer.tpl"}

