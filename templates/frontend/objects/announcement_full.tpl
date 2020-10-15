{**
 * templates/frontend/objects/announcement_full.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the full view of an announcement, when the announcement is
 *  the primary element on the page.
 *
 * @uses $announcement Announcement The announcement to display
 *}
<div id="main-content">
    {include file="frontend/components/breadcrumbs.tpl" currentTitle=$announcement->getLocalizedTitle() breadcrumbtype="announcement"}
    <article class="announcement-tpl mt-5">
        <header>
            <div class="announcement-date mb-1">
                <i class="fas fa-calendar-alt" aria-hidden="true"></i>
                <time>{$announcement->getDatePosted()|date_format:"%e. %B %Y"}</time>
            </div>
            <h1 class="announcement-title mb-3">
                {$announcement->getLocalizedTitle()}
            </h1>
        </header>
        <div>
            {if $announcement->getLocalizedDescription()}
                {$announcement->getLocalizedDescription()|strip_unsafe_html}
            {else}
                {$announcement->getLocalizedDescriptionShort()|strip_unsafe_html}
            {/if}
        </div>
    </article><!-- .announcement-full" -->
</div>