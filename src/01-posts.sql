/**
 * WordPress Resurrection
 *
 * @author Léo Colombaro <colombaro.fr>
 * @license ISC
 */

-- -- -- --
-- Posts
-- -- -- --

-- Delete obsolete indexes
DROP INDEX `comment_count` ON `#DB_PREFIX#posts`;
DROP INDEX `post_date` ON `#DB_PREFIX#posts`;
DROP INDEX `post_modified` ON `#DB_PREFIX#posts`;
DROP INDEX `post_password` ON `#DB_PREFIX#posts`;
DROP INDEX `post_related` ON `#DB_PREFIX#posts`;
DROP INDEX `post_status` ON `#DB_PREFIX#posts`;
DROP INDEX `post_type` ON `#DB_PREFIX#posts`;
DROP INDEX `wp_greet_box_post_related` ON `#DB_PREFIX#posts`;
DROP INDEX `yarpp_content` ON `#DB_PREFIX#posts`;
DROP INDEX `yarpp_title` ON `#DB_PREFIX#posts`;

-- --
-- WARNING: STRONG CLEANUP

-- Delete obsolete post types
--DELETE FROM `#DB_PREFIX#posts`
--WHERE `post_type` NOT IN ('post')
--;

-- Delete obsolete status
--DELETE FROM `#DB_PREFIX#posts`
--WHERE `post_status` NOT IN ('published')
--;

-- END WARNING
-- --

-- Delete unused children
DELETE FROM `#DB_PREFIX#posts`
WHERE `post_parent` = 0000
;

-- Delete obsolete rows
ALTER TABLE `#DB_PREFIX#posts` DROP `post_category`;
ALTER TABLE `#DB_PREFIX#posts` DROP `robotsmeta`;
