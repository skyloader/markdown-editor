#!/usr/bin/env perl
use strict;
use utf8;                                       # for hangle
use warnings;

use Mojolicious::Lite;
use Text::MultiMarkdown;
my $m = Text::MultiMarkdown->new;

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

get '/' => sub {
  my $self = shift;
  $self->render('editor');
};

post '/convert' => sub {
    my $self = shift;
    my $markdown = $self->param('markdown') || q{};
    my $html = $m->markdown($markdown);
    return $self->render_json( { html=> $html } );
    #return $self->render( html=>$html  );
};

app->start;
__DATA__

@@ editor.html.ep
% layout 'default';
% title 'Seoul.pm Markdown Editor';
<div id="editor-layout" class="container">
  <div class="row">
    <div class="span6">
      <h2>Markdown</h2>
      <textarea id="editor-markdown" class="span6" rows="28"></textarea>
      <button id="editor-apply" class="btn btn-primary pull-right" type="button">Apply</button>
    </div>
    <div class="span6">
      <h2>HTML</h2>
      <div id="editor-html"></div> 
    </div>
  </div>
</div>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head>
    <title><%= title %></title>

    <!-- Bootstrap -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
  </head>

  <body>
    <div class="navbar navbar-static-top">
  	  <div class="navbar-inner">
  	    <div class="container">
  	      <a class="btn btn-navbar" data-toggle="collapse" data-target=".navbar-responsive-collapse">
  	        <span class="icon-bar"></span>
  	        <span class="icon-bar"></span>
  	        <span class="icon-bar"></span>
  	      </a>
  	      <a class="brand" href="#">Seoul.pm Markdown Editor</a>
  	      <div class="nav-collapse collapse navbar-responsive-collapse">
  	        <ul class="nav">
  	          <li class="dropdown">
  	            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
  	            <ul class="dropdown-menu">
  	              <!-- <li><a href="#">Open Mkd file</a></li> -->
  	              <li><a id="fileupload" href="#">Open Mkd file</a></li>
  	              <li><a href="#">Save as HTML</a></li>
  	              <li><a href="#">Save as Mkd</a></li>
  	              <li class="divider"></li>
  	              <li><a href="#">Open at New tab</a></li>
  	            </ul>
  	          </li>
  	        </ul>
  	        <ul class="nav pull-right">
  	          <li class="divider-vertical"></li>
  	          <li class="navbar-search pull-right" action="">
  	            <input type="text" class="search-query span2" placeholder="Search">
              </li>
  	        </ul>
  	      </div><!-- /.nav-collapse -->
  	    </div>
  	  </div><!-- /navbar-inner -->
    </div><!-- /navbar -->
    
    <%= content %>
    <script src="jquery-1.8.3.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script src="markdown-editor.js"></script>
  </body>
</html>

@@ func.html.ep
% layout 'default', csses => [], jses => [ qw( jquery.ui.widget.js jquery.iframe-transport.js jquery.fileupload.js func.js ) ];
% title 'Generate Func Report';
<div>
  <form action="/coverage-report/func" method="post" class="form-horizontal">

    %= include 'file';
    %= include 'information';
    %= include 'func-configuration';

    <div class="form-actions">
      <input class="btn btn-primary" type="submit" value="Generate">
    </div>
  </form>
</div>


