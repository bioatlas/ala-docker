<?php
/**
 * The template for displaying 404 pages (Not Found)
 *
 */
?>

<?php get_header(); ?>

<?php get_template_part('template-part', 'topnav'); ?>

  <section id="breadcrumb">
    <div class="container">
      <div class="row">
        <ul class="breadcrumb-list">
          <li><a href="/">Home</a></li>
        </ul>
      </div>
    </div>
  </section>

  <div class="container">
    <section class="content-container">
      <div class="row">
        <article class="col-md-12 header-wrap margin-bottom-half-1">
          <h5 class="subject-category-overline">Error</h5>
          <h2 class="subject-title">Page not found</h2>
        </article>
        <article class="col-md-3 col-md-push-9 sidebar-col">
        </article>
        <article class="col-md-8 col-md-pull-3">
          <p>Sorry, it looks like that URL is not quite right.</p>
          <p>You could try a search...</p>
          <p><?php get_search_form(); ?></p>
          <p>If you get a chance, please report this via Feedback at bottom right.</p>
        </article><?php // End .col-md-8 col-md-pull-3  ?>
      </div><?php // End .row  ?>
    </section><?php // End .content-container  ?>
  </div><?php // End .container  ?>

<?php get_footer(); ?>