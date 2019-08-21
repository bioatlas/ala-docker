<!-- Navbar start -->
  <nav class="navbar navbar-default navbar-fixed-top">
    <div class="container container-navbar">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="/">
          <img alt="Brand" src="<?php echo get_stylesheet_directory_uri(); ?>/img/bas-logo-2016-inline.png">
        </a>
      </div>

      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <div class="row row-search">

          <div class="col-xs-12 col-sm-4 col-md-6">
            <form id="global-search" class="banner" action="https://beta.bioatlas.se/ala-bie/search" method="get" name="search-form">
              <div class="icon-addon addon-lg">
                <input type="text" placeholder="Search the Atlas ..." class="form-control autocomplete" id="biesearch" name="q">
                <label for="biesearch" class="glyphicon glyphicon-search" rel="tooltip" title="search"></label>
              </div>
            </form>
          </div>
        </div><!-- End row -->
        <ul class="nav navbar-nav">
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
              Start exploring
              <span class="caret"></span>
            </a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="https://beta.bioatlas.se/ala-hub/">Search species occurrences</a></li>
              <li class="divider"></li>
              <li><a href="https://beta.bioatlas.se/collectory/">Search Data Partners</a></li>
              <li><a href="https://beta.bioatlas.se/collectory/datasets/">Search Datasets</a></li>
              <li class="divider"></li>
              <li><a href="https://beta.bioatlas.se/images/">View images</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
              Search &amp; analyse
              <span class="caret"></span>
            </a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="https://beta.bioatlas.se/ala-hub/search#tab_spatialSearch">Explore by polygon</a></li>
              <li><a href="https://beta.bioatlas.se/ala-hub/explore/your-area">Explore by location</a></li>
              <li><a href="/regions/">Explore by region</a></li>
              <li class="divider"></li>
 <!--             <li><a href="https://downloads.ala.org.au">Download data</a>
 -->
              <li><a href="/spatial-hub/">Spatial portal</a></li>
              <li class="divider"></li>
              <li><a href="/mirroreum/">Mirroreum</a></li>
              <li class="divider"></li>
              <li><a href="https://beta.bioatlas.se/api/">Our APIs</a></li>
            </ul>
          </li>
<!--
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
              Participate
              <span class="caret"></span>
            </a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="https://biocollect.ala.org.au/acsa">Join a Citizen Science project</a></li>
              <li><a href="https://sightings.ala.org.au/">Record a sighting in the ALA</a></li>
              <li><a href="/submit-dataset-to-ala/">Submit a dataset to the ALA</a></li>
              <li><a href="https://digivol.ala.org.au/">Digitise a record in DigiVol</a></li>
            </ul>
          </li>
-->
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
              About
              <span class="caret"></span>
            </a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="/about/">About Us</a></li>
              <li class="divider"></li>
              <li><a href="/how-to-use-the-bioatlas/">How to use the BioAtlas</a></li>
              <li><a href="/how-to-work-with-data/">How to work with data</a></li>
              <li><a href="/how-to-cite-the-bioatlas/">How to cite the BioAtlas</a></li>
              <li class="divider"></li>
              <li><a href="/the-living-atlases-community/">Living Atlases Community</a></li>
              <li><a href="/the-gbif-network/">GBIF Network</a></li>
              <li class="divider"></li>
              <li><a href="/category/news/">BioAtlas News</a></li>
              <li class="divider"></li>
              <li><a href="/privacy-policy/">Privacy Policy</a></li>
              <li><a href="/contact/">Contact Us</a></li>
            </ul>
          </li>
        </ul>
        <ul class="nav navbar-nav navbar-right visible-xs">
        </ul>
      </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
  </nav>
  <!-- End Navbar -->
