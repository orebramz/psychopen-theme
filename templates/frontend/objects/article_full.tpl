{include file="frontend/components/header.tpl" pageTitleTranslated=$article->getLocalizedTitle()|escape}
{capture assign="pdfUrl"}{url op="download" path=$article->getBestArticleId($currentJournal)|to_array:$galley->getBestGalleyId($currentJournal):$galleyFile->getId() escape=false}{/capture}
{capture assign="parentUrl"}{url page="article" op="view" path=$article->getBestArticleId($currentJournal)}{/capture}
<div id="main-content" class="article-full-tpl">
    <div class="row justify-content-center mb-1">
        <div class="col-12">
            {$userSession}
            <div class="btn-group btn-group-sm float-right">
                <a href="{$parentUrl}" class="btn btn-secondary btn-download">
                    <i class="fas fa-arrow-left"></i>
                    {translate key="article.return"}
                </a>
                {foreach from=$article->getGalleys() item=galley}
                    {if $galley->isPdfGalley()}
                        {assign var="hasArticleAccess" value=$hasAccess}
	                    {if $currentContext->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_OPEN || $publication->getData('accessStatus') == $smarty.const.ARTICLE_ACCESS_OPEN}
                            {assign var="hasArticleAccess" value=1}
                        {/if}
                        {include file="frontend/objects/galley_link.tpl" parent=$article hasAccess=$hasArticleAccess download=true custom_classes="btn btn-secondary btn-download"
                        purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency') hasAccess=$hasArticleAccess}
                    {/if}
                {/foreach}
                <button id="article-full" class="btn btn-secondary btn-download">
                    <i class="fas fa-expand-arrows-alt"></i>&nbsp;{translate key="plugins.themes.psychOpen.article.view.full"}
                </button>
            </div>
        </div>
    </div>
    <div class="row justify-content-center mb-1">
        <article class="col-12">
            <div class="row">
                <div class="col-12" id="article-frame-row">
                    <div id="article-full-close-row" class="text-right">
                        <button class="btn btn-secondary btn-download" id="article-full-close">
                            <i class="fas fa-times-circle"></i>&nbsp;{translate key="plugins.themes.psychOpen.article.view.full.close"}
                        </button>
                    </div>
                    {if $htmlViewer}
                        <iframe id="article-html-frame" class="article-full-frame" {*onload="resizeIframe(this)"*} oncontextmenu="return false;"
                                src="{url page="article" op="download"  path=$article->getBestArticleId()|to_array:$galley->getBestGalleyId() inline=true}"></iframe>
                    {/if}
                    {if $pdfViewer}
                        <iframe class="article-full-frame" src="{$pluginUrl}/pdfjs/web/viewer.html?file={$pdfUrl}" allowfullscreen></iframe>
                    {/if}
                </div>
            </div>
        </article>
    </div>
</div>
{include file="frontend/components/footer.tpl"}
