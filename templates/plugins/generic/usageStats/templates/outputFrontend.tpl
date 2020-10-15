{**
 * plugins/generic/usageStats/templates/outputFrontend.tpl
 *
 * Copyright (c) 2013-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Add HTML markup for a usage stats graph on the frontend
 *
 * @uses $pubObjectType The type of object this graph will respresent.
 *   Example: PublishedArticle
 * @uses $pubObjectId The id of the object tihs graph will represent.
 *}
<li class="list-group-item item downloads_chart">
    <div class="row mb-1">
        <div class="col-12">
            <strong>{translate key="plugins.generic.usageStats.downloads"}:</strong>
        </div>
    </div>
    <div class="value row">
        <div class="col-12">
            <canvas class="usageStatsGraph" data-object-type="{$pubObjectType}" data-object-id="{$pubObjectId|escape}"></canvas>
            <div class="usageStatsUnavailable" data-object-type="{$pubObjectType}" data-object-id="{$pubObjectId|escape}">
                {translate key="plugins.generic.usageStats.noStats"}
            </div>
        </div>
    </div>
</li>