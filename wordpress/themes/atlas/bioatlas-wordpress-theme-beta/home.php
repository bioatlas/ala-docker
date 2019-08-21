<?php get_header(); ?>

<?php get_template_part('template-part', 'topnav'); ?>

<div class="jumbotron ala-header hidden-print" id="ala-jumbotron" style="background-image: url(&quot;/wp-content/themes/atlas/img/jtron-bg-month-02-770px.gif&quot;);">
    <div class="container">
      <div class="col-lg-6 col-md-8 col-sm-12 promotional"><strong>Biodiversity Atlas Sweden</strong> is part of the <strong>Swedish Biodiversity Data Infrastructure</strong>, which aggregates Swedish biodiversity data and makes it freely available and usable online.</div>
    </div>
  </div>
<?php // theloop - but only for the alert
  if ( have_posts() ) : while ( have_posts() ) : the_post();
    if( get_post_meta($post->ID, 'ALACustomAlertMessage', true) ) { ?>
    <!-- Promotional alert -->
  <div class="alert alert-ala-default alert-dismissible" role="alert">
    <div class="container">
      <div class="row-fluid">
        <div class="col-md-12">
          <button type="button" class="close" data-dismiss="alert" aria-label="Close" title="Close"><span aria-hidden="true">&times;</span></button>
          <p><?php echo get_post_meta($post->ID, 'ALACustomAlertMessage', true); ?></p>
        </div>
      </div>
    </div>
  </div>
  <!-- End promotional alert -->
<?php } ?>
<?php endwhile; ?>
<?php endif; ?>
  <!-- Container -->
  <div class="container" id="main">

    <div class="col-md-8 col-md-offset-2 hidden">
      <h1 class="heading-large margin-bottom-quarter-1">BioAtlas Sweden</h1>
      <h2 class="promotional">
        Biodiversity Atlas Sweden is a collaborative, national project that aggregates biodiversity data from multiple sources and makes it freely available and usable online.
      </h2>
    </div>

    <!-- Main stats -->
    <div class="col-md-12">
      <div class="main-stats row">
        <div class="main-stats col-lg-3 col-md-3 col-sm-6">
          <h4>Occurrence Records</h4>
          <div class="stat-number" id="allRecords">
            72,710,155
          </div>
        </div>

        <div class="main-stats col-lg-3 col-md-3 col-sm-6">
          <h4>Institutions</h4>
          <div class="stat-number" id="allInstitutions">
            17
          </div>
        </div>
        <div class="main-stats col-lg-3 col-md-3 col-sm-6">
          <h4>Datasets</h4>
          <div class="stat-number" id="allDatasets">
            43
          </div>
        </div>
        <div class="main-stats col-lg-3 col-md-3 col-sm-6">
          <h4>Species</h4>
          <div class="stat-number" id="allSpecies">
            105,000
          </div>
        </div>

      </div><!-- End main stats -->
    </div>


    <!-- Main col -->
    <div class="col-md-12">
<!--
      <div class="col-lg-4 col-md-4 col-sm-6">
        <div class="panel panel-default">
          <a href="https://beta.bioatlas.se/bie/iconic-species"><img class="img-responsive" src="<?php echo get_stylesheet_directory_uri(); ?>/img/homepage-channel-image-bird.jpg" alt="Bird"></a>
          <div class="panel-body">
            <h3><a href="https://beta.bioatlas.se/bie/iconic-species">Swedish iconic species</a></h3>
            <p class="help-block">
              Browse some of our most popular species, or search all species in Bioatlas.
            </p>
          </div>
        </div>
      </div>
-->
      <div class="col-lg-4 col-md-4 col-sm-6">
        <div class="panel panel-default">
          <a href="https://beta.bioatlas.se/collectory/"><img class="img-responsive" src="<?php echo get_stylesheet_directory_uri(); ?>/img/homepage-channel-image-bird.jpg" alt="Bird"></a>
          <div class="panel-body">
            <h3><a href="https://beta.bioatlas.se/collectory/">Swedish Collections and Observations</a></h3>
            <p class="help-block">
              Browse our Swedish biodiversity collections and observation data.
            </p>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-md-4 col-sm-6">
        <div class="panel panel-default">
          <a href="https://beta.bioatlas.se/ala-hub/explore/your-area"><img class="img-responsive" src="<?php echo get_stylesheet_directory_uri(); ?>/img/homepage-channel-image-beetle.jpg" alt="Beetle"></a>
          <div class="panel-body">
            <h3><a href="https://beta.bioatlas.se/ala-hub/explore/your-area">Explore by Location</a></h3>
            <p class="help-block">
              Browse species by pre-defined <a href="/regions/">region</a> or by <a href="https://beta.bioatlas.se/ala-hub/explore/your-area">location</a>.
            </p>
          </div>
        </div>
      </div>
      <div class="col-lg-4 col-md-4 col-sm-6">
        <div class="panel panel-default">
          <a href="https://beta.bioatlas.se/ala-hub/"><img class="img-responsive" src="<?php echo get_stylesheet_directory_uri(); ?>/img/homepage-channel-image-rainbow.jpg" alt="Rainbow Beetle"></a>
          <div class="panel-body">
            <h3><a href="https://beta.bioatlas.se/ala-hub/">Mapping and Analysis</a></h3>
            <p class="help-block">
              Explore species occurrence records using the <a href="/spatial-hub/">Spatial Portal</a> or <a href="https://beta.bioatlas.se/ala-hub/">search records</a> for species occurrences.
            </p>
          </div>
        </div>
      </div>
      <!-- End Col -->
      <div class="col-lg-4 col-md-4 col-sm-6">
        <div class="panel panel-default">
          <a href="/mirroreum/">
            <img class="img-responsive" src="<?php echo get_stylesheet_directory_uri(); ?>/img/ala-info-hub-education-icon.jpg" alt="Calendar Events">
          </a>
          <div class="panel-body">
            <h3><a href="/mirroreum/">Reproducible Research</a></h3>
            <p class="help-block">
              Use <a href="/mirroreum/">Mirroreum</a> for Open Science based studies with R using data from BioAtlas.
            </p>
          </div>
        </div>
      </div>
      <div class="col-lg-4 col-md-4 col-sm-6">
        <div class="panel panel-default">
          <a href="/category/news/">
            <img class="img-responsive" src="<?php echo get_stylesheet_directory_uri(); ?>/img/ala-info-hub-how-you-can-icon.jpg" alt="ALA news icon">
          </a>
          <div class="panel-body">
            <h3><a href="/category/news/">News</a></h3>
            <p class="help-block">
              Browse <a href="/category/news/">news and blog posts</a> from the BioAtlas community, and keep up to date with how we are engaging with our users.
            </p>
          </div>
        </div>
      </div>
      <div class="col-lg-4 col-md-4 col-sm-6">
        <div class="panel panel-default">
          <a href="/events/"><img class="img-responsive" src="<?php echo get_stylesheet_directory_uri(); ?>/img/ala-info-hub-get-involved-icon.jpg" alt="Contribute icon"></a>
          <div class="panel-body">
            <h3><a href="/events/">Calendar</a></h3>
            <p class="help-block">
              <a href="/events/">Events</a> for the BioAtlas community, national and international meetings and conferences.
            </p>
          </div>
        </div>
      </div>
      <!-- End Col -->
    </div><!-- End main col -->

  </div><!-- end content container -->

<?php 
$GLOBALS['ALAcontentType'] = 'Channel';
get_footer(); 
?>
