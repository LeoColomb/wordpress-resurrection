/**
 * WordPress Resurrection
 *
 * @author Léo Colombaro <colombaro.fr>
 * @license ISC
 */

-- -- -- --
-- Terms
-- -- -- --

-- Delete orphaned terms
DELETE FROM `#DB_PREFIX#term_taxonomy`
WHERE `term_id` NOT IN (SELECT `term_id` FROM `#DB_PREFIX#terms`)
;
DELETE FROM `#DB_PREFIX#term_relationships`
WHERE `term_taxonomy_id` NOT IN (SELECT `term_taxonomy_id` FROM `#DB_PREFIX#term_taxonomy`)
;
