{**
 * templates/frontend/pages/searchAuthorIndex.tpl
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
{include file="frontend/components/header.tpl" pageTitle="search.authorIndex"}
<div id="main-content" class="search-tpl">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="search.authorIndex" breadcrumbtype="authorIndex"}
    <nav class="">
        <ul class="pagination mt-4 mb-3">
            <li class="page-item {if $searchInitial == ''}active{/if}">
                <a class="page-link" href="{url op="authors"}">
                    {translate key="common.all"}
                </a>
            </li>
            {foreach from=$alphaList item=letter}
                <li class="page-item {if $letter == $searchInitial}active{/if}">
                    <a class="page-link" href="{url op="authors" searchInitial=$letter}">
                        {$letter|escape}
                    </a>
                </li>
            {/foreach}
        </ul>
    </nav>

    <ul class="list-group list-group-flush">
        {iterate from=authors item=author}
        {assign var=lastFirstLetter value=$firstLetter}
        {assign var=firstLetter value=$author->getLocalizedGivenName()|String_substr:0:1}

            {*{if $lastFirstLetter|lower != $firstLetter|lower}
                <div id="{$firstLetter|escape}">
                    <h3>{$firstLetter|escape}</h3>
                </div>
            {/if}*}

        {assign var=lastAuthorName value=$authorName}
        {assign var=lastAuthorCountry value=$authorCountry}

        {assign var=authorAffiliation value=$author->getLocalizedAffiliation()}
        {assign var=authorCountry value=$author->getCountry()}

        {assign var=authorGivenName value=$author->getLocalizedGivenName()}
        {assign var=authorFamilyName value=$author->getLocalizedFamilyName()}
        {assign var=authorName value=$author->getFullName(false, true)}

        {strip}
            <li class="list-group-item">
                <a href="{url op="authors" path="view" givenName=$authorGivenName familyName=$authorFamilyName affiliation=$authorAffiliation country=$authorCountry authorName=$authorName}">
                    {$authorName|escape}
                </a>
                {if $authorAffiliation}, {$authorAffiliation|escape}{/if}
                {if $lastAuthorName == $authorName && $lastAuthorCountry != $authorCountry}
                    {* Disambiguate with country if necessary (i.e. if names are the same otherwise) *}
                    {if $authorCountry} ({$author->getCountryLocalized()}){/if}
                {/if}
            </li>
        {/strip}

        {/iterate}
    </ul>
    {if !$authors->wasEmpty()}
        <div class="row mt-3 mb-3">
            <div class="col">{page_info iterator=$authors}</div>
            <div class="col-auto">{page_links anchor="authors" iterator=$authors name="authors" searchInitial=$searchInitial}</div>
        </div>
    {else}
    {/if}

</div>
{include file="frontend/components/footer.tpl"}

