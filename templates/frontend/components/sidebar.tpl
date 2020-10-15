{**
 * templates/frontend/components/sidebar.tpl
 *
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the sidebar. Extracted from the footer for a better overview
 *
 * @uses $sidebarCode
 *}
<aside id="sidebar" class="col-12 col-sm-12 col-md-12 col-lg-4 col-xl-4" aria-label="{translate|escape key="common.navigation.sidebar"}">
    {if empty($isFullWidth)}
        {capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
        {if $sidebarCode}
            <div>
                {$sidebarCode}
            </div>
        {/if}
    {/if}
</aside>