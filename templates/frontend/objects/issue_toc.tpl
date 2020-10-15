{**
 * templates/frontend/objects/issue_toc.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a full table of contents.
 *
 * @uses $issue Issue The issue
 * @uses $issueTitle string Title of the issue. May be empty
 * @uses $issueSeries string Vol/No/Year string for the issue
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $publishedSubmissions array Lists of articles published in this issue sorted by section.
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 *}
<div>
    {* Indicate if this is only a preview *}
    {if !$issue->getPublished()}
        {include file="frontend/components/notification.tpl" type="alert-warning" messageKey="editor.issues.preview"}
    {/if}
    {* Issue introduction area above articles *}
    <section class="row font-layout">
        {assign var="issueDetailsCol" value="12"}
        {* Issue cover image and description*}
        {assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
        {if $issueCover}
            <div class="col-auto">
                <a class="mr-2 mb-2 float-left" href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
                    <img src="{$issueCover|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
                </a>
            </div>
        {elseif $issueThumb && $issue->hasDescription()}
            <div class="col-auto">
                <a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}" aria-label="{$issueSeries|escape}">
                    <img class="issue-summary-image" src="{$publicFilesDir}/{$issueThumb}" alt="Issue Cover">
                </a>
            </div>
        {/if}
        <div class="col">
            {if  !$indexPage && $issue->getLocalizedTitle()|strip_unsafe_html}
                <h1 class="border-bottom mb-3">{$issue->getLocalizedTitle()|strip_unsafe_html}&nbsp;[{$issue->getIssueSeries()}]</h1>
            {/if}
            {if $issue->hasDescription()}
                {$issue->getLocalizedDescription()|strip_unsafe_html}
            {/if}
            {* PUb IDs (eg - DOI) *}
            {foreach from=$pubIdPlugins item=pubIdPlugin}
                {if $issue->getPublished()}
                    {assign var=pubId value=$issue->getStoredPubId($pubIdPlugin->getPubIdType())}
                {else}
                    {assign var=pubId value=$pubIdPlugin->getPubId($issue)}{* Preview pubId *}
                {/if}
                {if $pubId}
                    {assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
                    <p class="pub_id {$pubIdPlugin->getPubIdType()|escape}">
                        <strong>
                            {$pubIdPlugin->getPubIdDisplayType()|escape}:
                        </strong>
                        {if $doiUrl}
                            <a href="{$doiUrl|escape}">
                                {$doiUrl}
                            </a>
                        {else}
                            {$pubId}
                        {/if}
                    </p>
                {/if}
            {/foreach}
            {assign var="showVolPublishedDate" value=false}
            {if $showVolPublishedDate}
                {* Published date *}
                {if $issue->getDatePublished()}
                    <p class="published">
                        <strong>
                            {translate key="submissions.published"}:
                        </strong>
                        {$issue->getDatePublished()|date_format:$dateFormatShort}
                    </p>
                {/if}
            {/if}
            {if $issueGalleys}
                {* TODO  in*}
                <p>Go to full issue:
                    {foreach from=$issueGalleys item=galley}
                        {include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getSetting('purchaseIssueFee') purchaseCurrency=$currentJournal->getSetting('currency')}
                        {if !$galley@last},&nbsp;{/if}
                    {/foreach}
                </p>
            {/if}
        </div>
    </section>
    {* Full-issue galleys *}
    {*{if $issueGalleys}
        <div class="galleys article-footer-bar">
            <div class="page-header">
                <h2>
                    <small></small>
                </h2>
            </div>
            <div class="btn-group btn-group-sm">
                {foreach from=$issueGalleys item=galley}
                    {include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getSetting('purchaseIssueFee') purchaseCurrency=$currentJournal->getSetting('currency') custom_classes="btn btn-sm btn-outline-dark mt-lg-0 mt-3"}
                {/foreach}
            </div>
        </div>
    {/if}*}
    {* Articles *}
    {if $publishedSubmissions && sizeof($publishedSubmissions)>0}
        {assign var="publishedArticles" value=$publishedSubmissions}
    {/if}
    {foreach name=sections from=$publishedArticles item=section}
        <div class="card default-card-layout">
            <div class="card-body {if $loadSectionHeaderIssue!="true"}border-bottom{/if}">
                {if $section.articles}
                    {if $loadSectionHeaderIssue=="true"}
                        <div class="card-title mt-4">
                            <h2>{$section.title|escape}</h2>
                        </div>
                    {/if}
                    <ul class="list-group list-group-flush">
                        {foreach from=$section.articles item=article}
                            <li class="list-group-item">
                                {include file="frontend/objects/article_summary.tpl"}
                            </li>
                        {/foreach}
                    </ul>
                {/if}
            </div>
        </div>
    {/foreach}
</div><!-- .issue-toc -->
