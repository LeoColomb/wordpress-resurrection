/**
 * WordPress Resurrection
 *
 * @author Léo Colombaro <colombaro.fr>
 * @license ISC
 */

-- -- -- --
-- Post Meta
-- -- -- --

-- Delete orphaned meta
DELETE `#DB_PREFIX#postmeta` FROM `#DB_PREFIX#postmeta`
  LEFT JOIN `#DB_PREFIX#posts` ON `#DB_PREFIX#posts`.`ID` = `#DB_PREFIX#postmeta`.`post_id`
WHERE `#DB_PREFIX#posts`.`ID` IS NULL
;

-- --
-- WARNING: NEED CUSTOMIZATION

-- Dead meta
DELETE FROM `#DB_PREFIX#postmeta`
WHERE `meta_key` IN ('head_meta')
;

DELETE FROM `#DB_PREFIX#postmeta`
WHERE `meta_key` LIKE 'Author%'
      OR `meta_key` LIKE 'podPress%'
      OR `meta_key` LIKE '_tdomf%'
      OR `meta_key` LIKE 'aktt_%'
      OR `meta_key` LIKE 'jorgen_%'
      OR `meta_key` LIKE '_oembed_%'
      OR `meta_key` LIKE 'ml-slider%'
      OR `meta_key` LIKE 'mtp%'
      OR `meta_key` LIKE 'readability_%'
      OR `meta_key` LIKE 'user_submit_%'
      OR `meta_key` LIKE '%wpcf-%'
      OR `meta_key` LIKE '%ailster_%'
      OR `meta_key` LIKE 'wpdc_%'
      OR `meta_key` LIKE '_aioseop_%'
      OR `meta_key` LIKE '_rocket_%'
      OR `meta_key` LIKE '_menu_item_%'
      OR `meta_key` LIKE '_flattr_%'
      OR `meta_key` LIKE '_expiration-%'
      OR `meta_key` LIKE '_wptouch_%'
      OR `meta_key` LIKE '_wpb_%'
      OR `meta_key` LIKE '_wp_rp_%'
      OR `meta_key` LIKE '_yoast_%'
      OR `meta_key` LIKE 'video_t%'
      OR `meta_key` LIKE 'word_stats_%'
      OR `meta_key` LIKE 'ucontext4a_%'
      OR `meta_key` LIKE '%_template'
;

-- END WARNING
-- --

-- Update old attached files
UPDATE `#DB_PREFIX#postmeta` SET `meta_value` = REGEXP_REPLACE(`meta_value`, '.*/wp-content/uploads/([0-9]+/.*)', '\\1')
WHERE `meta_key` = '_wp_attached_file'
      AND `meta_value` LIKE '%/wp-content/uploads/%'
;

SET @reg_file_path = 's:4:"file";s:[0-9]+:"/.*/wp-content/uploads/([0-9]+/(.(?!"))*.)";';
UPDATE `#DB_PREFIX#postmeta` SET `meta_value` = REGEXP_REPLACE(
    `meta_value`,
    @reg_file_path,
    CONCAT(
        's:4:"file";s:',
        LENGTH(REGEXP_REPLACE(`meta_value`, @reg_file_path, '\\1')),
        ':"\\1";'
    )
)
WHERE `meta_key` LIKE '_wp_attachment%'
      AND `meta_value` LIKE '%/wp-content/uploads/%'
;

-- Reduce index size
SET @num := 0;
UPDATE `#DB_PREFIX#postmeta` SET `meta_id` = @num := (@num + 1);
ALTER TABLE `#DB_PREFIX#postmeta` AUTO_INCREMENT = 1;
