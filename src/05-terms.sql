/**
 * WordPress Resurrection
 *
 * @author Léo Colombaro <colombaro.fr>
 * @license ISC
 */

-- -- -- --
-- Terms
-- -- -- --

-- --
-- WARNING: NEED CUSTOMIZATION

-- Delete uncommon terms
DELETE wt FROM `#DB_PREFIX#terms` wt
  INNER JOIN `#DB_PREFIX#term_taxonomy` wtt
    ON wt.`term_id` = wtt.`term_id`
WHERE wtt.`taxonomy` IN ('post_tag', 'video_tag', 'nav_menu', 'ml-slider', 'link_category')
;

-- END WARNING
-- --

-- Delete orphaned terms
DELETE FROM `#DB_PREFIX#term_taxonomy`
WHERE `term_id` NOT IN (SELECT `term_id` FROM `#DB_PREFIX#terms`)
;
DELETE FROM `#DB_PREFIX#term_relationships`
WHERE `term_taxonomy_id` NOT IN (SELECT `term_taxonomy_id` FROM `#DB_PREFIX#term_taxonomy`)
;
