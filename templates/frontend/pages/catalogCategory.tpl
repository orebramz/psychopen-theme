{**
 * templates/frontend/pages/catalogCategory.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view a category of the catalog.
 *
 * @uses $category Category Current category being viewed
 * @uses $publishedSubmissions array List of published submissions in this category
 * @uses $parentCategory Category Parent category if one exists
 * @uses $subcategories array List of subcategories if they exist
 * @uses $prevPage int The previous page number
 * @uses $nextPage int The next page number
 * @uses $showingStart int The number of the first item on this page
 * @uses $showingEnd int The number of the last item on this page
 * @uses $total int Count of all published submissions in this category
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$category->getLocalizedTitle()}
<div id="main-content" class="catalog_category_tpl">
    {* Breadcrumb *}
    {include file="frontend/components/breadcrumbs.tpl" type="category" parent=$parentCategory currentTitle=$category->getLocalizedTitle()}
    {* Image and description *}
    {assign var="image" value=$category->getImage()}
    {assign var="description" value=$category->getLocalizedDescription()|strip_unsafe_html}
    {if $image || $description}
        <section class="row font-layout" aria-label="{translate key="plugins.themes.psychOpen.aria.category.desc"}">
            <div class="col-12">
                {if $image}
                    <a class="float-left" href="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="fullSize" type="category" id=$category->getId()}">
                        <img src="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="thumbnail" type="category" id=$category->getId()}"
                             alt="{$category->getLocalizedTitle()|escape}"/>
                    </a>
                {/if}
                <div>
                    {$description|strip_unsafe_html}
                </div>
            </div>
        </section>
    {/if}
    {if $parentCategory}
        <section class="row mt-4">
            <div class="col-auto">
                <strong>
                    {translate key="plugins.themes.psychOpen.categories.parent"}:
                </strong>
            </div>
            <div class="col-auto">
                <a href="{url op="category" path=$parentCategory->getPath()}">
                    <span class="badge badge-dark">{$parentCategory->getLocalizedTitle()|escape}</span>
                </a>
            </div>
        </section>
    {/if}
    {if !$subcategories->wasEmpty()}
        <section class="row mt-4">
            <div class="col-12">
                <strong>
                    {translate key="plugins.themes.psychOpen.categories.sub"}:
                </strong>
            </div>
            <div class="col-12">
                <ul class="list-group list-group-horizontal list-group-no-border">
                    {iterate from=subcategories item=subcategory}
                        <li class="list-group-item mr-2">
                            <a href="{url op="category" path=$subcategory->getPath()}">
                                <span class="badge badge-dark">{$subcategory->getLocalizedTitle()|escape}</span>
                            </a>
                        </li>
                    {/iterate}
                </ul>
            </div>
        </section>
    {/if}
    <section class="row mt-4">
        <div class="col-12">
            <strong>
                {translate key="plugins.themes.psychOpen.categories.heading" numTitles=$total}
            </strong>
            {* No published titles in this category *}
            {if empty($publishedSubmissions)}
                <p>{translate key="catalog.category.noItems"}</p>
            {else}
                <ul class="list-group list-group-no-border">
                    {foreach from=$publishedSubmissions item=article}
                        <li class="list-group-item">
                            {include file="frontend/objects/article_summary.tpl"}
                        </li>
                    {/foreach}
                </ul>
                {* Pagination *}
                {if $prevPage > 1}
                    {capture assign=prevUrl}{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()|to_array:$prevPage}{/capture}
                {elseif $prevPage === 1}
                    {capture assign=prevUrl}{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()}{/capture}
                {/if}
                {if $nextPage}
                    {capture assign=nextUrl}{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()|to_array:$nextPage}{/capture}
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
        </div>
    </section>
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
