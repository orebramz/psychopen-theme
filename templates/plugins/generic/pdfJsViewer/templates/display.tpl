{include file="frontend/components/header.tpl" pageTitleTranslated=$title|escape}
<div id="main-content" class="article-full-tpl">
    <div class="row justify-content-center mb-1">
        <div class="col-12">
            {$userSession}
            <div class="btn-group btn-group-sm float-right">
                <a href="{$parentUrl}" class="btn btn-secondary btn-download">
                    <i class="fas fa-arrow-left"></i>
                    {if $article}
                        {translate key="article.return"}
                    {else}
                        {translate key="issue.return"}
                    {/if}
                </a>
                <a class="btn btn-secondary btn-download galley-link" role="button" href="{$pdfUrl}" aria-label="PDF Download">
                    <i class="fas fa-file-download"></i>&nbsp;{translate key="common.download"}
                </a>
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
                        <button class="btn btn-sm btn-secondary btn-download" id="article-full-close">
                            <i class="fas fa-times-circle"></i>&nbsp;{translate key="plugins.themes.psychOpen.article.view.full.close"}
                        </button>
                    </div>
                    <iframe id="article-html-frame" class="article-full-frame" {*onload="resizeIframe(this)"*} oncontextmenu="return false;"
                            src="{$pluginUrl}/pdf.js/web/viewer.html?file={$pdfUrl|escape:"url"}"></iframe>

                </div>
            </div>
        </article>
    </div>
</div>
<script>
	document.querySelector("#article-html-frame").addEventListener("load", function () {
		let innerDoc = this.contentDocument || this.contentWindow.document
		let embedScriptEl = innerDoc.createElement('script');
		embedScriptEl.src = 'https://hypothes.is/embed.js';
		embedScriptEl.setAttribute("async", "async");
		innerDoc.head.appendChild(embedScriptEl);
		{if $article}
		let added = false;
		this.addEventListener("mouseenter", function () {
			if (!added) {
				added = true;
				pushGoal('article_PDF_view', '{$article->getBestArticleId()}', 1);
			}
		})
		{/if}
	});
</script>
{include file="frontend/components/footer.tpl"}
