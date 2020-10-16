{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $hasAccess bool Can this user access galleys for this context? The context may be an issue or an article
 * @uses $showDatePublished bool Show the date this article was published?
 * @uses $hideGalleys bool Hide the article galleys for this article?
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 * @uses $catLoaded bool True, if submission categories are loaded by the loadCategoryBySubmission function
 * @uses $articleCat array List of categories which belong to the submission
 *}
{assign var=articlePath value=$article->getBestArticleId($currentJournal)}
{if is_array($section)}
    {assign var="hideAuthor" value=$section.hideAuthor}
{/if}
{if (!$hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
    {assign var="showAuthor" value=true}
{/if}
<div class="article-sum">
    <div class="media">
        {* TODO cover set to false *}
        {if $article->getLocalizedCoverImage() && false}
            <a href="{url page="article" op="view" path=$articlePath}" class="mr-2 mb-1 article-sum-href align-self-start">
                <img src="{$article->getLocalizedCoverImageUrl()|escape}" alt="{$article->getLocalizedTitle($article->getLocale())|strip_unsafe_html}">
            </a>
        {/if}
        <div class="media-body">
            {assign var="catLoaded" value={loadCategoryBySubmission submissionId=$article->getCurrentPublication()->getId()}}
            {if $catLoaded}
                <div class="row article-category">
                    <div class="col-12">
                        {foreach from=$articleCat item=category}
                            <a href="{url page="catalog" op="category" path=$category->getPath()}"><span class="badge badge-dark">{$category->getLocalizedTitle()}</span></a>
                        {/foreach}
                    </div>
                </div>
            {/if}
            {* TITLE *}
            <h2 class="article-title">
                <a href="{url page="article" op="view" path=$articlePath}">
                    {$article->getLocalizedTitle($article->getLocale())|strip_unsafe_html}
                </a>
            </h2>
            {* TRANSLATED TITLE *}
            {if sizeof($currentJournal->getSupportedLocaleNames())>1}
                <h4 class="article-trans-title text-muted">
                    {if sizeof($currentJournal->getSupportedLocaleNames())>1}
                        {foreach from=$currentJournal->getSupportedLocaleNames() item=itm key=localekey}
                            {if $localekey != $article->getLocale()}
                                {$article->getLocalizedTitle($localekey)|escape}
                            {/if}
                        {/foreach}
                    {/if}
                </h4>
            {/if}
            {* SUBTITLE *}
            {if $article->getLocalizedSubtitle()}
                <h3 class="article-subtitle text-muted">
                    {$article->getLocalizedSubtitle($article->getLocale())|escape}
                </h3>
            {/if}
            {* AUTHORS *}
            {if $showAuthor}
                <div class="row article-authors">
                    <div class="col-12">
                        {$article->getAuthorString()}
                        {*{foreach from=$article->getAuthors() item=author}
                            {$author->getOrcid()}
                        {/foreach}*}
                    </div>
                </div>
            {/if}
        </div>
    </div>
    <div class="row article-footer-bar text-nowrap">
        {* Published date *}
        {if $article->getDatePublished()}
            <div class="col-auto col-lg">
                <i class="fas fa-calendar-alt"></i>
                {if $issue && $issue->getDatePublished() && $article->getDatePublished()|strtotime < $issue->getDatePublished()|strtotime}
                    {$issue->getDatePublished()|date_format:"%e. %B %Y"}
                {else}
                    {$article->getDatePublished()|date_format:"%e. %B %Y"}
                {/if}
            </div>
        {elseif $issue && $issue->getDatePublished()}
            <div class="col-auto col-lg">
                <i class="fas fa-calendar-alt"></i>
                &nbsp;{$issue->getDatePublished()|date_format:"%e. %B %Y"}
            </div>
        {/if}
        {* Page numbers for this article *}
        {* TODO set as theme option!!!*}
        {assign var="showPages" value=true}
        {if $article->getPages() && $showPages}
            <div class="article-pages col-auto col-lg">
                <i class="fas fa-file-alt"></i>
                {$article->getPages()|escape}
            </div>
        {/if}
        <div class="col-auto col-lg">
            {assign var=galleys value=$article->getGalleys()}
            {if $galleys}
                {assign var="abstractViews" value={getAbstractViews fileId=$article->getId()}}
                {assign var="galleysTotalView" value=$abstractViews}
                {foreach from=$galleys item=galley name=galleyList}
                    {assign var="galleysTotalView" value=$galleysTotalView+$galley->getViews()}
                {/foreach}
                <div data-toggle="tooltip" data-placement="left" data-html="true" class="float-sm-right float-right float-md-left"
                     title="{translate key="plugins.themes.psychOpen.article.details.abstract"}: {$abstractViews}<br />{foreach from=$galleys item=galley name=galleyList}{$galley->getLabel()}: {$galley->getViews()} <br />{/foreach}">
                    <i class="fa fa-eye" aria-hidden="true"></i>&nbsp;{$galleysTotalView}
                </div>
            {/if}
        </div>
        {if !($loadSideBar=='true' && ($requestedPage=='index' || $requestedPage==''))}
            <div class="col-auto col-lg mt-lg-0">
                {if $article->getStoredPubId("doi")!=""}
                    <i class="fas fa-external-link-alt"></i>
                    &nbsp;
                    <a href="https://doi.org/{$article->getStoredPubId("doi")}">https://doi.org/{$article->getStoredPubId("doi")}</a>
                {/if}
            </div>
        {/if}
        <div class="col-12 col-lg col-xl">
            {if $article->getGalleys()}
                <div class="btn-group btn-group-sm float-left float-lg-right">
                    {foreach from=$article->getGalleys() item=galley}
                        {if $galley->getLabel()|escape == "PDF" || $galley->getLabel()|escape == "HTML" || $galley->getLabel()|escape == "XML"}
                            {if $primaryGenreIds || !$hideGalleys}
                                {assign var="file" value=$galley->getFile()}
                                {*{if $galley->getRemoteUrl() || ($file && in_array($file->getGenreId(), $primaryGenreIds))}*}
                                {assign var="hasArticleAccess" value=$hasAccess}
	                            {if $currentContext->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_OPEN || $publication->getData('accessStatus') == $smarty.const.ARTICLE_ACCESS_OPEN}
                                    {assign var="hasArticleAccess" value=1}
                                {/if}
                                {include file="frontend/objects/galley_link.tpl" parent=$article hasAccess=$hasArticleAccess custom_classes="btn btn-sm btn-outline-dark mt-lg-0 mt-3"}
                                {*{/if}*}
                            {/if}
                        {/if}
                    {/foreach}
                </div>
            {/if}
        </div>
    </div>

    {call_hook name="Templates::Issue::Issue::Article"}
</div><!-- .article-summary -->
