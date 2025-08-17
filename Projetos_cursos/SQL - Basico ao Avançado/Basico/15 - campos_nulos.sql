/*Como remover campos nulos no filtro*/

SELECT
    order_id,
    review_comment_title,
    review_comment_message
FROM tb_order_reviews

WHERE review_comment_title is not NULL