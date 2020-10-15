{if $announcementsSidebar && sizeof($announcementsSidebar)>0}
    <section class="card mb-3 default-card-layout">
        <div class="card-body">
            <div class="card-title">
                <h2>{translate key="announcement.announcements"}</h2>
            </div>
            <ul class="list-group list-group-flush">
                {foreach name=announcements from=$announcementsSidebar item=announcement}
                    <li class="list-group-item">
                        <article class="announcement-summary-tpl">
                            <header class="row announcement-heading">
                                <div class="col">
                                    <a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}">
                                        <h3>{$announcement->getLocalizedTitle()|escape}</h3>
                                    </a>
                                </div>
                                <div class="col-12 small font-weight-bold">{$announcement->getDatePosted()|date_format:"%e. %B %Y"}</div>
                            </header><!-- .announcement-heading -->
                            <div class="row announcement-content">
                                <div class="col-12">
                                    {$announcement->getLocalizedDescriptionShort()|strip_unsafe_html|regex_replace:"/(<p>|<p [^>]*>)/":""|regex_replace:"/(<\\/p>)/":"<br>"}
                                </div>
                            </div><!-- .announcement-content-->
                        </article><!-- .announcement-summary -->
                    </li>
                {/foreach}
            </ul>
        </div>
    </section>
{/if}