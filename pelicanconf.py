#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

import os


AUTHOR = u'Andy R. Terrel'

SITENAME = u'Codematician'
SITESUBTITLE = u'Homepage of Andy R. Terrel'
SITEURL = '' # change in publishconf.py

# Times and dates
DEFAULT_DATE_FORMAT = '%b %d, %Y'
TIMEZONE = 'US/Pacific'
DEFAULT_LANG = u'en'

# Set the article URL
ARTICLE_URL = 'blog/{date:%Y}/{date:%m}/{date:%d}/{slug}/'
ARTICLE_SAVE_AS = 'blog/{date:%Y}/{date:%m}/{date:%d}/{slug}/index.html'

# Title menu options
DISPLAY_PAGES_ON_MENU = False
MENUITEMS = [('Vita', '/vita/'),
#             ('Research', '/research.html'),
#             ('Software', '/software.html'),
             ('Archives', '/archives.html')]
NEWEST_FIRST_ARCHIVES = True

#Github include settings used in octopress and neat themes
GITHUB_USER = 'aterrel'
GITHUB_REPO_COUNT = 5
GITHUB_SKIP_FORK = True
GITHUB_SHOW_USER_LINK = True

# Blogroll
#LINKS =  (('Pelican', 'http://docs.notmyidea.org/alexis/pelican/'),
#          ('Python.org', 'http://python.org'),
#          ('Jinja2', 'http://jinja.pocoo.org'),
#          ('You can modify those links in your config file', '#'),)

# Social widget
SOCIAL =  (('Twitter', '//twitter.com/aterrel'),
           ('Github', '//github.com/aterrel'),
           ('Bitbucket', '//bitbucket.org/aterrel/'),
           ('Google Scholar', '//scholar.google.com/citations?user=ALzCmCEAAAAJ&hl=en'),
           ('LinkedIn', '//www.linkedin.com/in/aterrel'))
# (('You can add links in your config file', '#'),
#          ('Another social link', '#'),)

DEFAULT_PAGINATION = 10

# STATIC_OUT_DIR requires pelican 3.3
STATIC_OUT_DIR = ''
STATIC_PATHS = ['CNAME', 'images', 'figures', 'downloads', 'papers_and_talks']
CODE_DIR = 'downloads/code'
NOTEBOOK_DIR = 'downloads/notebooks'

# Theme and plugins
#  Theme requires http://github.com/duilio/pelican-octopress-theme/
#  Plugins require http://github.com/getpelican/pelican-plugins/
# Theme
THEME_DIR = os.path.join(os.getcwd(), "theme")
THEME_NAME = "tuxlite_tbs"
THEME = os.path.join(THEME_DIR, THEME_NAME)
RECENT_ARTICLES_COUNT = 3

PLUGIN_PATHS = ['../pelican-plugins/']
PLUGINS = ['summary',
           'liquid_tags',
#           'liquid_tags.img',
#           'liquid_tags.video',
#           'liquid_tags.include_code',
           # 'liquid_tags.notebook',
#           'liquid_tags.literal',
           ]
LIQUID_TAGS = ['img',
               'video',
               'include_code',
               'literal',
               ]

# The theme file should be updated so that the base header contains the line:
#
#  {% if EXTRA_HEADER %}
#    {{ EXTRA_HEADER }}
#  {% endif %}
#
# This header file is automatically generated by the notebook plugin
EXTRA_HEADER = open('_nb_header_mod.html').read()

# Sharing
TWITTER_USER = 'aterrel'
GOOGLE_PLUS_USER = 'andy.terrel@gmail.com'
GOOGLE_PLUS_ONE = True
GOOGLE_PLUS_HIDDEN = False
FACEBOOK_LIKE = False
TWITTER_TWEET_BUTTON = True
TWITTER_LATEST_TWEETS = True
TWITTER_FOLLOW_BUTTON = True
TWITTER_TWEET_COUNT = 3
TWITTER_SHOW_REPLIES = 'false'
TWITTER_SHOW_FOLLOWER_COUNT = 'true'


# RSS/Atom feeds
FEED_DOMAIN = SITEURL
FEED_ATOM = 'atom.xml'
FEED_RSS = 'rss.xml'
#TAG_FEED_ATOM = 'feeds/%s-tag.atom.xml'
#TAG_FEED_RSS = 'feeds/%s-tag.rss.xml'

# Search
SEARCH_BOX = True
