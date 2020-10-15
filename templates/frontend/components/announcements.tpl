{**
 * templates/frontend/components/announcements.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a list of announcements
 *
 * @uses $announcements array List of announcements
 *}

<ul class="mb-5 list-group list-group-flush">
	{foreach from=$announcements item=announcement}
		<li class="list-group-item">
			{include file="frontend/objects/announcement_summary.tpl" sidebar=false hideHTMLParagraph=true}
		</li>
	{/foreach}
</ul>
