/**
 * WordPress Resurrection
 *
 * @author Léo Colombaro <colombaro.fr>
 * @license ISC
 */

-- -- -- --
-- Posts: HTML
-- -- -- --

-- Remove XHTML font tags
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    '</?font[^>]*>',
    ''
)
WHERE `post_content` REGEXP '</?font'
;

-- Remove excessive p tags
UPDATE `#DB_PREFIX#posts` SET `post_content` = REGEXP_REPLACE(
    `post_content`,
    '</?p(\\\s[^>]*)?>',
    '\n\r'
)
WHERE `post_content` REGEXP '</?p[^a-z]'
;
