{**
 * templates/frontend/objects/announcement_summary.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a summary view of an announcement
 *
 * @uses $announcement Announcement The announcement to display
 *}
<article class="announcement-summary-tpl">
    <header class="row announcement-heading">
        <div class="col">
            <a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}">
                <h2>{$announcement->getLocalizedTitle()|escape}</h2>
            </a>
        </div>
        <div class="{if $sidebar}col-12{else}col-auto{/if}">
            <time class="small font-weight-bold">{$announcement->getDatePosted()|date_format:"%e. %B %Y"}</time>
        </div>
    </header><!-- .announcement-heading -->
    <div class="row announcement-content">
        <div class="col-12">
            {if $hideHTMLParagraph}
                {$announcement->getLocalizedDescriptionShort()|strip_unsafe_html|regex_replace:"/(<p>|<p [^>]*>)/":""|regex_replace:"/(<\\/p>)/":"<br>"}
            {else}
                {$announcement->getLocalizedDescriptionShort()|strip_unsafe_html}
            {/if}
        </div>
    </div><!-- .announcement-content-->
</article><!-- .announcement-summary -->

