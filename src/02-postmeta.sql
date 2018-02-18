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
