<?php
//define('WP_USE_THEMES', false);
$GLOBALS['ALAcontentType'] = 'Channel';
get_header(); ?>

<?php get_template_part('template-part', 'topnav'); ?>
<!-- category.php -->
 <!-- Breadcrumb -->
  <section id="breadcrumb">
    <div class="container">
      <div class="row">
        <ul class="breadcrumb-list">
          <li><a href="/">Home</a></li>
<?php if ( get_cat_slug($cat) == "news" ) : ?>
          <li>BioAtlas News</li>
<?php else: ?>
          <li><a href="/category/news/">BioAtlas News</a></li>
          <li active"><?php single_cat_title(); ?></li>
<?php endif; ?>
        </ul>
      </div>
    </div>
  </section>
  <!-- End breadcrumb -->

  <div class="container">
    <section class="content-container">
      <div class="row">

<?php
$postsperpage = get_option('posts_per_page');
$paged = ( get_query_var('paged') ) ? get_query_var('paged') : 1;
$args = array(
  'posts_per_page'   => $postsperpage,
  'cat'              => $cat,
  'post_type'        => 'post',
  'post_status'      => 'publish',
  'paged'            => $paged
);
?>
          <div class=" col-md-12 col-sm-12"><h5 class="subject-category-overline">Channel</h5></div>
          <div class="col-md-8 col-sm-12">
<?php if ( get_cat_slug($cat) == "news" ) : ?>
          <h2 class="subject-title">BioAtlas Blog</h2>
          <h3 class="subject-subtitle">News and events from the BioAtlas community.</h3>
<?php else: ?>
          <h2 class="subject-title"><?php single_cat_title(); ?></h2>
          <h3 class="subject-subtitle"><?php echo category_description($cat); ?></h3>
<?php endif; ?>
          </div>
          <div class="dropdown col-md-4 col-sm-12 margin-bottom-2">
            <button class="btn btn-default dropdown-toggle" type="button" id="categoriesMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
              Categories
              <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" aria-labelledby="categoriesMenu">
          <?php 
          $catargs = array(
              'exclude'            => 1,
              'title_li'           => '',
          );
          wp_list_categories($catargs) ?>
            </ul>
          </div>
      </div>

<?php
// the query
$the_query = new WP_Query( $args ); ?>

<?php if ( $the_query->have_posts() ) :
  $postCounter = 0;
  // start The Loop
  while ( $the_query->have_posts() ) : $the_query->the_post();
    $postCounter = ++$postCounter;
    $thumbsize = 'thumb-med';
    $blog_thumb_url = wp_get_attachment_image_src( get_post_thumbnail_id(), $thumbsize);
?>
      <div class="row">
<div class="col-md-12">
  <div class="panel panel-default panel-blog">
    <div class="panel-body row">
      <div class="col-md-8">
        <h3>
          <a href="<?php the_permalink();?>"><?php the_title(); ?></a>
        </h3>
        <p class="heading-underlined"><?php the_time('j F, Y'); ?>
          <?php
          $this_post_categories = get_the_category();
          post_category_links($this_post_categories);
          ?>
        </p>
        <?php if ( $post->post_excerpt ) : ?>
          <p><?php echo $post->post_excerpt ;?></p>
        <?php endif; ?>
        <?php
        // $posttags = get_the_tags();
        // if ($posttags) {
        //   echo '<p class="subject-byline">Tags: ';
        //   foreach($posttags as $tag) {
        //     echo '<span class="label label-ala">' . $tag->name . '</span> ';
        //   }
        //   echo '</p>';
        // }
        ?>
        <!-- <p class="subject-byline">Tags:&ensp;<span class="label label-ala">News</span> <span class="label label-ala">Data</span></p> -->
      </div>
<?php if ($blog_thumb_url) { ?>
      <div class="col-md-4"><img class="img-responsive" src="<?php echo $blog_thumb_url[0]; ?>" alt="Image: <?php the_title(); ?>"></div>
<?php } ?>
    </div>
  </div>
</div>
</div>
  <?php
  endwhile;
  // end The Loop
  ?>

  <?php if ($the_query->max_num_pages > 1) { // check if the max number of pages is greater than 1  ?>
    <!-- total list pages for this category: <?php echo $the_query->max_num_pages ?> -->
    <nav>
      <ul class="pager">
        <li class="previous"><?php echo get_previous_posts_link( '<span aria-hidden="true">&larr;</span> Newer posts' ); ?></li>
        <li class="next"><?php echo get_next_posts_link( 'Older posts <span aria-hidden="true">&rarr;</span>', $the_query->max_num_pages ); ?></li>
      </ul>
    </nav>
  <?php } ?>

  <?php wp_reset_postdata(); ?>

  <?php else: ?>
    <article>
      <h1>Sorry...</h1>
      <p><?php _e('Sorry, no posts matched your criteria.'); ?></p>
    </article>
  <?php endif; ?>



      </div><?php // End .row  ?>
    </section><?php // End .content-container  ?>

  </div><?php // End .container  ?>

<?php get_footer(); ?>
