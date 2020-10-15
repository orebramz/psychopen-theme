{**
 * templates/frontend/pages/search.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to search and view search results.
 *
 * @uses $query Value of the primary search query
 * @uses $authors Value of the authors search filter
 * @uses $dateFrom Value of the date from search filter (published after).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $dateTo Value of the date to search filter (published before).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $yearStart Earliest year that can be used in from/to filters
 * @uses $yearEnd Latest year that can be used in from/to filters
 *}
{include file="frontend/components/header.tpl" pageTitle="common.search"}
<div id="main-content" class="search-tpl">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="common.search"}
    <div class="row">
        <div class="col-12 col-lg-4">
            <form method="post" id="search-form" class="search-form" action="{url op="search"}" role="search">
                {csrf}
                {*<div class="row">
                    <div class="col-12">
                        <h1>{translate key="common.search"}</h1>
                    </div>
                </div>*}
                <div class="card">
                    <div class="card-body">
                        <div class="form-group">
                            <label class="sr-only" for="query">
                                {translate key="search.searchFor"}
                            </label>
                            <div class="input-group input-group-sm">
                                <input type="text" id="query" name="query" value="{$query|escape}" class="query form-control" placeholder="{translate key="common.search"}">
                                <div class="input-group-append">
                                    <button type="submit" class="btn btn-secondary">{translate key="common.search"}</button>
                                </div>
                            </div>
                        </div>
                        <div class="form-group text-right">
                            <button class="btn btn-outline-secondary btn-sm" type="button" data-toggle="collapse" data-target="#collapseFilters" aria-expanded="false"
                                    aria-controls="collapseFilters">
                                {translate key="search.advancedFilters"}
                            </button>
                        </div>
                        <div class="collapse" id="collapseFilters">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group ">
                                        <label for="dateFromYear">
                                            {translate key="search.dateFrom"}
                                        </label>
                                        {if $dateFrom == $dateTo}
                                            {assign var="dateFrom" value="{$yearStart}-01-01"}
                                        {/if}
                                        {html_select_date prefix="dateFrom" time=$dateFrom start_year=$yearStart end_year=$yearEnd field_order="YMD" year_empty="" month_empty="" day_empty="" all_extra="class='form-control form-control-sm'"
                                        }
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label for="dateToYear">
                                            {translate key="search.dateTo"}
                                        </label>
                                        {*{html_select_date prefix="dateTo" time=$dateTo start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD"}*}
                                        {html_select_date prefix="dateTo" time=$dateTo start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD" all_extra="class='form-control form-control-sm'"}
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="authors">
                                    {translate key="search.author"}
                                </label>
                                <input class="form-control form-control-sm" type="text" name="authors" id="authors" value="{$authors|escape}">
                            </div>
                            <div class="form-group">
                                <label for="title">
                                    {translate key="search.title"}
                                </label>
                                <input class="form-control form-control-sm" type="text" name="title" id="title" value="{$title|escape}">
                            </div>
                            <div class="form-group">
                                <label for="subject">
                                    {translate key="search.subject"}
                                </label>
                                <input class="form-control form-control-sm" type="text" name="subject" id="subject" value="{$subject|escape}">
                            </div>
                            <div class="row">
                                <div class="form-group col-6">
                                    <label for="orderBy">
                                        {translate key="search.results.orderBy"}
                                    </label>
                                    <select class="form-control" name="orderBy" id="orderBy">
                                        {assign var="options" value=array(
                                        {translate key="search.results.orderBy.relevance"},
                                        {translate key="search.results.orderBy.article"},
                                        {translate key="search.results.orderBy.author"},
                                        {translate key="search.results.orderBy.popularityAll"},
                                        {translate key="search.results.orderBy.popularityMonth"}
                                        )}
                                        {assign var="vals" value=array('score','title','authors','popularityAll','popularityMonth')}
                                        {html_options values=$vals output=$options selected=$orderBy}
                                    </select>
                                </div>
                                <div class="form-group col-6">
                                    <label for="orderDir">
                                        &nbsp;
                                    </label>
                                    <select class="form-control" name="orderDir" id="orderDir">
                                        {assign var="options" value=array(
                                        {translate key="search.results.orderDir.asc"},
                                        {translate key="search.results.orderDir.desc"})}
                                        {assign var="vals" value=array('asc','desc')}
                                        {html_options values=$vals output=$options selected=$orderDir}
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mt-3">
                    <div class="card-body">
                        <a href="{url page="search" op="authors"}">{translate key="search.browseAuthorIndex"}</a>
                    </div>
                </div>
            </form>
        </div>
        {* Search results *}
        <div class="col-12 col-lg-8 mt-3 mt-lg-0">
            <h3 class="font-weight-bold">
                {translate key="search.searchResults"}
            </h3>
            {call_hook name="Templates::Search::SearchResults::PreResults"}
            {* No results found *}
            {if $results->wasEmpty()}
                {if $error}
                    {include file="frontend/components/notification.tpl" type="alert-danger" message=$error|escape}
                {else}
                    {include file="frontend/components/notification.tpl" type="alert-dark" messageKey="search.no.Results"}
                {/if}
            {else}
                <ul class="list-group list-group-flush">
                    {iterate from=results item=result}
                        <li class="list-group-item">{include file="frontend/objects/article_summary.tpl" article=$result.publishedArticle showDatePublished=true hideGalleys=false}</li>
                    {/iterate}
                </ul>
                {* Results pagination *}
                <div class="row mt-3 mb-3">
                    <div class="col">
                        {page_info iterator=$results}
                    </div>
                    <div class="col-auto">
                        {page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors title=$title abstract=$abstract galleyFullText=$galleyFullText discipline=$discipline subject=$subject type=$type coverage=$coverage indexTerms=$indexTerms dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear orderBy=$orderBy orderDir=$orderDir}
                    </div>
                </div>
            {/if}
        </div>
    </div><!-- .page -->
</div>
{include file="frontend/components/footer.tpl"}
