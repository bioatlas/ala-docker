<?php
  $post = $wp_query->post;
  //default content type
  $GLOBALS['ALAcontentType'] = 'Page';
  if ( is_page('home') ) {
    include (locate_template('home.php'));
    
  } else {
    include (locate_template('page_core.php'));
  }
?>
