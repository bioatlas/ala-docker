<?php get_header(); ?>

<?php get_template_part('template-part', 'topnav'); ?>

 <!-- Breadcrumb -->
  <section id="breadcrumb">
    <div class="container">
      <div class="row">
        <ul class="breadcrumb-list">
          <li><a href="/">Home</a></li>
          <li class="active"><?php the_title() ;?></li>
        </ul>
      </div>
    </div>
  </section>
  <!-- End breadcrumb -->

  <div class="container">
    <section class="content-container">
      <div class="row">

        <?php // theloop
        if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>

        <article class="col-md-12 header-wrap margin-bottom-half-1">
          <h5 class="subject-category-overline"><?php echo $GLOBALS['ALAcontentType'] ;?></h5>
          <h2 class="subject-title"><?php the_title() ;?></h2>
<?php if ( $post->post_excerpt ) : ?>
          <h3 class="subject-subtitle"><?php echo $post->post_excerpt ;?></h3>
<?php endif; ?>
<?php if ( $GLOBALS['ALAcontentType'] == 'Article' ) : ?>
          <p class="subject-byline"><!--By <?php the_author(); ?>, --><?php echo get_the_date() ;?></p>
<?php
  $categories = get_the_category();
  $separator = ' ';
  $output = '';
  if($categories){
    $output .= '<p class="subject-byline">Categories: ';
    foreach($categories as $category) {
      $output .= '<a href="'.get_category_link( $category->term_id ).'" title="' . esc_attr( sprintf( __( "View all posts in %s" ), $category->name ) ) . '"><span class="label label-ala">'.$category->cat_name.'</span></a>'.$separator;
      // $output .= '<span class="label label-ala">'.$category->cat_name.'</span>'.$separator;
    }
    $output .= '</p>';
  echo trim($output, $separator);
  }
?>
<?php endif; ?>
        </article>

<?php if ( $GLOBALS['ALAcontentType'] != 'Channel' ) : ?>

        <article class="col-md-12" id="alaEditable">
        <!-- Start editable content -->
            <?php the_content(); ?>
            <?php wp_link_pages(); ?>
        <!-- End editable content -->
        </article><?php // End .col-md-12  ?>

<?php else: ?>

        <div class="col-md-12" id="alaEditable">
        <!-- Start editable content -->
            <?php the_content(); ?>
            <?php wp_link_pages(); ?>
        <!-- End editable content -->
        </div><?php // End .col-md-12  ?>

<?php endif; ?>

        <?php endwhile; ?>
        <?php else: ?>

            <?php get_404_template(); ?>

        <?php endif; ?>

      </div><?php // End .row  ?>
    </section><?php // End .content-container  ?>

  </div><?php // End .container  ?>

<?php get_footer(); ?>
