{**
 * templates/frontend/pages/announcements.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the latest announcements
 *
 * @uses $announcements array List of announcements
 *}
{include file="frontend/components/header.tpl" pageTitle="announcement.announcements"}

<div id="main-content">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="announcement.announcements"}
    <div class="row mb-4">
        <div class="col-12">
            <div class="float-right">
                {include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="announcements" sectionTitleKey="announcement.announcements"}
            </div>
            {$announcementsIntroduction}
        </div>
    </div>
    {include file="frontend/components/announcements.tpl"}
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
