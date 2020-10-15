{**
 * templates/frontend/components/navigationMenu.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Primary navigation menu list for OJS
 *
 * @uses navigationMenu array Hierarchical array of navigation menu item assignments
 * @uses id string Element ID to assign the outer <ul>
 * @uses ulClass string Class name(s) to assign the outer <ul>
 * @uses liClass string Class name(s) to assign all <li> elements
 *}
{if $navigationMenu}
    <ul id="{$id|escape}" class="{$ulClass|escape}" {if $id=='main-navigation' && ($requestedPage=='index' || $requestedPage=='')} itemid="main_nav_elem" role="menu" {/if}>
        {foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
            {if $navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
                {assign var="hasChildren" value=false}
                {if !empty($navigationMenuItemAssignment->children)}
                    {assign var="hasChildren" value=true}
                {/if}
                <li class="{$liClass|escape}{if $hasChildren} dropdown{/if}">
                    {if $hasChildren}
                        <a href="#"
                           class="dropdown-toggle {if $id=='navigationUser'}btn btn-sm btn-outline-light mr-1{else}nav-link{/if}"
                           data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            {$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                            <span class="caret"></span>
                        </a>
                    {else}
                        <a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}"
                           class="{if $id=='navigationUser'}btn btn-sm btn-outline-light mr-1{else}nav-link{/if}">
                            {$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                        </a>
                    {/if}
                    {if !empty($navigationMenuItemAssignment->children)}
                        <div class="dropdown-menu {if $id === 'navigationUser'}dropdown-menu-right{/if}">
                            {foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
                                {if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
                                    <a class="dropdown-item" href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}">
                                        {$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
                                    </a>
                                {/if}
                            {/foreach}
                        </div>
                    {/if}
                </li>
            {/if}
        {/foreach}
    </ul>
{/if}
