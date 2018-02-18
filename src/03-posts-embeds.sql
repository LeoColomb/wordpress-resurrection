/**
 * WordPress Resurrection
 *
 * @author Léo Colombaro <colombaro.fr>
 * @license ISC
 */

-- -- -- --
-- Posts: Embeds
-- -- -- --

-- This script converts hard-coded embeds to simple URLs.
-- This change allows the WordPress instance to take two advantages:
-- * Being much more flexible regarding embed APIs changes on each hosted
--   service.
-- * Using WordPress embeds API to follow theme requirements.

SET @reg_pre = '(https?:)?//(www\\.)?';
SET @reg_prep = '(<|&lt;)(iframe|object|embed).*';
SET @reg_post = '.*(iframe|object|embed)(>|&gt;)';
SET @reg_tar = '\n\r';

-- YouTube Lists
SET @reg_youtube_list = 'youtube\\.com/embed/[\\w\\-]+(\\?list=[\\w\\-]+)';
SET @reg_youtube_list_tar = 'https://www.youtube.com/playlist';
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT(@reg_prep, @reg_pre, @reg_youtube_list, @reg_post),
    CONCAT(@reg_tar, @reg_youtube_list_tar, '\\5', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT(@reg_prep, @reg_pre, @reg_youtube_list)
;
UPDATE `#DB_PREFIX#postmeta` SET `meta_value` = REGEXP_REPLACE(
    `meta_value`,
    CONCAT('.*', @reg_pre, @reg_youtube_list, '.*'),
    CONCAT(@reg_youtube_list_tar, '\\3')
)
WHERE `meta_key` = 'video_url'
      AND `meta_value` REGEXP CONCAT(@reg_pre, @reg_youtube_list)
;

-- YouTube Old
SET @reg_youtube_o = 'youtube\\.com/v/([\\-\\w]+)';
SET @reg_youtube_tar = 'https://www.youtube.com/watch?v=';
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT('(<|&lt;)object.*', @reg_pre, @reg_youtube_o, '.*object(>|&gt;)'),
    CONCAT(@reg_tar, @reg_youtube_tar, '\\4', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT('(<|&lt;)object.*', @reg_pre, @reg_youtube_o)
;
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT(@reg_prep, @reg_pre, @reg_youtube_o, @reg_post),
    CONCAT(@reg_tar, @reg_youtube_tar, '\\5', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT(@reg_prep, @reg_pre, @reg_youtube_o)
;

-- YouTube
SET @reg_youtube = 'youtube\\.com/embed/([\\-\\w]+)';
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT(@reg_prep, @reg_pre, @reg_youtube, @reg_post),
    CONCAT(@reg_tar, @reg_youtube_tar, '\\5', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT(@reg_prep, @reg_pre, @reg_youtube)
;
UPDATE `#DB_PREFIX#postmeta` SET `meta_value` = REGEXP_REPLACE(
    `meta_value`,
    CONCAT('.*', @reg_pre, @reg_youtube, '.*'),
    CONCAT(@reg_youtube_tar, '\\3')
)
WHERE `meta_key` = 'video_url'
      AND `meta_value` REGEXP CONCAT(@reg_pre, @reg_youtube)
;

-- Dailymotion
SET @reg_daily = 'dailymotion\\.com/embed/video/([a-z\\d]+)';
SET @reg_daily_tar = 'https://www.dailymotion.com/video/';
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT(@reg_prep, @reg_pre, @reg_daily, @reg_post),
    CONCAT(@reg_tar, @reg_daily_tar, '\\5', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT(@reg_prep, @reg_pre, @reg_daily)
;
UPDATE `#DB_PREFIX#postmeta` SET `meta_value` = REGEXP_REPLACE(
    `meta_value`,
    CONCAT('.*', @reg_pre, @reg_daily, '.*'),
    CONCAT(@reg_daily_tar, '\\3')
)
WHERE `meta_key` = 'video_url'
      AND `meta_value` REGEXP CONCAT(@reg_pre, @reg_daily)
;
SET @reg_daily_old = 'dailymotion\\.com/swf/([a-z\\d]+)';
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT(@reg_prep, @reg_pre, @reg_daily_old, @reg_post),
    CONCAT(@reg_tar, @reg_daily_tar, '\\5', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT(@reg_prep, @reg_pre, @reg_daily_old)
;

-- Vimeo
SET @reg_vimeo = 'player\\.vimeo\\.com/video/(\\d+)';
SET @reg_vimeo_tar = 'https://vimeo.com/';
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT(@reg_prep, @reg_pre, @reg_vimeo, @reg_post),
    CONCAT(@reg_tar, @reg_vimeo_tar, '\\5', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT(@reg_prep, @reg_pre, @reg_vimeo)
;
UPDATE `#DB_PREFIX#postmeta` SET `meta_value` = REGEXP_REPLACE(
    `meta_value`,
    CONCAT('.*', @reg_pre, @reg_vimeo, '.*'),
    CONCAT(@reg_vimeo_tar, '\\3/')
)
WHERE `meta_key` = 'video_url'
      AND `meta_value` REGEXP CONCAT(@reg_pre, @reg_vimeo)
;
SET @reg_vimeo_old = 'vimeo\\.com/moogaloop\\.swf\\?clip_id=(\\d+)';
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT(@reg_prep, @reg_pre, @reg_vimeo_old, @reg_post),
    CONCAT(@reg_tar, @reg_vimeo_tar, '\\5', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT(@reg_prep, @reg_pre, @reg_vimeo_old)
;

-- Vine
SET @reg_vine = 'vine\\.co/v/([a-z\\d]+)/embed/simple';
SET @reg_vine_tar = 'https://vine.co/v/';
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT(@reg_prep, @reg_pre, @reg_vine, @reg_post),
    CONCAT(@reg_tar, @reg_vine_tar, '\\5', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT(@reg_prep, @reg_pre, @reg_vine)
;

-- TED
SET @reg_ted = 'embed(-ssl)?\\.ted\\.com/talks/([\\-\\w]+)\\.?';
SET @reg_ted_tar = 'https://www.ted.com/talks/';
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT(@reg_prep, @reg_pre, @reg_ted, @reg_post),
    CONCAT(@reg_tar, @reg_ted_tar, '\\6', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT(@reg_prep, @reg_pre, @reg_ted)
;
UPDATE `#DB_PREFIX#postmeta` SET `meta_value` = REGEXP_REPLACE(
    `meta_value`,
    CONCAT('.*', @reg_pre, @reg_ted, '.*'),
    CONCAT(@reg_ted_tar, '\\4')
)
WHERE `meta_key` = 'video_url'
      AND `meta_value` REGEXP CONCAT(@reg_pre, @reg_ted)
;
SET @reg_ted_old = 'video\\.ted\\.com/talks/.*adKeys=talk=([\\-\\w]+);';
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT(@reg_prep, @reg_pre, @reg_ted_old, @reg_post),
    CONCAT(@reg_tar, @reg_ted_tar, '\\5', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT(@reg_prep, @reg_pre, @reg_ted_old)
;

-- Spotify
SET @reg_spot = 'embed\\.spotify\\.com/\\?uri=spotify(:|%3A)track(:|%3A)([a-z\\d]+)';
SET @reg_spot_tar = 'https://open.spotify.com/track/';
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT(@reg_prep, @reg_pre, @reg_spot, @reg_post),
    CONCAT(@reg_tar, @reg_spot_tar, '\\7', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT(@reg_prep, @reg_pre, @reg_spot)
;

-- Scribd
SET @reg_scri = '[a-z]+\\.scribd\\.com/ScribdViewer\\.swf\\?document_id=(\\d+)';
SET @reg_scri_tar = 'https://www.scribd.com/doc/';
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT(@reg_prep, @reg_pre, @reg_scri, @reg_post),
    CONCAT(@reg_tar, @reg_scri_tar, '\\5', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT(@reg_prep, @reg_pre, @reg_scri)
;
SET @reg_scri = 'scribd\\.com/embeds/(\\d+)/';
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    CONCAT(@reg_prep, @reg_pre, @reg_scri, @reg_post),
    CONCAT(@reg_tar, @reg_scri_tar, '\\5', @reg_tar)
)
WHERE `post_content` REGEXP CONCAT(@reg_prep, @reg_pre, @reg_scri)
;
