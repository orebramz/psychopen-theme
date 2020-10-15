{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a summary for use in lists
 *
 * @uses $issue Issue The issue
 *}
{if $issue->getShowTitle()}
    {assign var=issueTitle value=$issue->getLocalizedTitle()}
{/if}
{assign var=issueSeries value=$issue->getIssueSeries()}
{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
<div class="card issue-summary-tpl">
    <div class="card-body">
        <div class="row">
            <div class="col-auto">
                {if $issueCover}
                    <a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}" aria-label="{$issueSeries|escape}">
                        <img class="issue-summary-image" src="{$issueCover}" alt="Issue Cover">
                    </a>
                {elseif $issueThumb}
                    <a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}" aria-label="{$issueSeries|escape}">
                        <img class="issue-summary-image" src="{$publicFilesDir}/{$issueThumb}" alt="Issue Cover">
                    </a>
                {/if}
            </div>
            <div class="col">
                <h2 class="card-title issue-summary-headline mb-2">
                    <a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">{$issueSeries|escape}</a><br/>
                </h2>
                <div class="mb-2"><i class="fas fa-calendar-alt"></i>&nbsp;{$issue->getDatePublished()|date_format:"%B %Y"}</div>
                {if $issueTitle}
                    <div class="mb-2">
                        {$issueTitle|escape}
                    </div>
                {/if}
                <span class="card-text text-justify">
                    <div>{$issue->getLocalizedDescription()|strip_unsafe_html|truncate:300}</div>
                </span>
            </div>
        </div>
    </div>
</div><!-- .issue-summary -->
