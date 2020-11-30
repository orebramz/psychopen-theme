{**
 * templates/frontend/objects/galley_link.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of a galley object as a link to view or download the galley, to be used
 *  in a list of galleys.
 *
 * @uses $galley Galley
 * @uses $parent Issue|Article Object which these galleys are attached to
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $restrictOnlyPdf bool Is access only restricted to PDF galleys?
 * @uses $purchaseArticleEnabled bool Can this article be purchased?
 * @uses $currentJournal Journal The current journal context
 * @uses $journalOverride Journal An optional argument to override the current
 *       journal with a specific context
 *}

{* Override the $currentJournal context if desired *}
{if $journalOverride}
    {assign var="currentJournal" value=$journalOverride}
{/if}

{* Determine galley type and URL op *}
{if $galley->isPdfGalley()}
    {assign var="type" value="pdf"}
    {assign var="view" value="view"}
{elseif "HTML" eq ($galley->getGalleyLabel())}
    {assign var="type" value="html"}
    {assign var="view" value="view"}
{elseif "XML" eq ($galley->getGalleyLabel())}
    {assign var="type" value="xml"}
    {assign var="view" value="view"}
{else}
    {assign var="type" value="file"}
    {assign var="view" value="view"}
{/if}

{* Get page and parentId for URL *}
{if $parent instanceOf Issue}
    {assign var="page" value="issue"}
    {assign var="parentId" value=$parent->getBestIssueId()}
{else}
    {assign var="page" value="article"}
    {assign var="parentId" value=$parent->getBestArticleId()}
{/if}

{* Get user access flag *}
{if !$hasAccess}
    {if $restrictOnlyPdf && $type=="pdf"}
        {assign var=restricted value="1"}
    {elseif !$restrictOnlyPdf}
        {assign var=restricted value="1"}
    {/if}
{/if}
{if $download}
    {assign var="view" value="download"}
{/if}
{if $page == 'issue' || $galley->getLabel()|escape|upper == "PDF" || $galley->getLabel()|escape|upper == "HTML" || $galley->getLabel()|escape|upper == "XML"}
{* Don't be frightened. This is just a link *}
    <a class="{$custom_classes} galley-link" role="button" href="{url page=$page op=$view path=$parentId|to_array:$galley->getBestGalleyId($currentJournal)}" aria-label="{$type}"
       onclick="pushGoal('{$page}_{if $page=='article'}{$galley->getLabel()|escape|upper}_{/if}action', '{$parentId}', 1);">
        {* Add some screen reader text to indicate if a galley is restricted *}
        {if $restricted}
            <i class="fas fa-lock" aria-hidden="true"></i>
            <span class="sr-only">
                {if $purchaseArticleEnabled}
                    {translate key="reader.subscriptionOrFeeAccess"}
                {else}
                    {translate key="reader.subscriptionAccess"}
                {/if}
            </span>
        {elseif $download}
            <i class="fas fa-file-download"></i>
        {/if}
        {if $download}
            {translate key="common.download"}
        {else}
            {$galley->getLabel()|escape}     {* Ersetzt $galley->getGalleyLabel() um den Sprachzusatz wie z. B. "(English)" wegzubekommen.*}
        {/if}
        {if $restricted && $purchaseFee && $purchaseCurrency}
            <span class="purchase-cost">
                {translate key="reader.purchasePrice" price=$purchaseFee currency=$purchaseCurrency}
            </span>
        {/if}
    </a>
{/if}
