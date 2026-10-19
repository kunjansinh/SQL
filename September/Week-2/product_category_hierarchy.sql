-- Name = Kunjan
-- Topic: Product Category Hierarchy
-- Purpose:
-- Traverse nested product categories using a recursive CTE.

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    parent_category_id INT NULL,
    FOREIGN KEY (parent_category_id)
        REFERENCES categories(category_id)
);

INSERT INTO categories VALUES
(1, 'Electronics', NULL),
(2, 'Computers', 1),
(3, 'Laptops', 2),
(4, 'Desktops', 2),
(5, 'Mobile Phones', 1),
(6, 'Clothing', NULL),
(7, 'Mens Clothing', 6),
(8, 'Womens Clothing', 6),
(9, 'T-Shirts', 7),
(10, 'Jeans', 7);

-- Traverse the hierarchy from each root category.
WITH RECURSIVE category_tree AS (
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS depth,
        CAST(category_name AS CHAR(1000)) AS category_path
    FROM categories
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ct.depth + 1,
        CONCAT(ct.category_path, ' > ', c.category_name)
    FROM categories c
    INNER JOIN category_tree ct
        ON c.parent_category_id = ct.category_id
)
SELECT
    category_id,
    category_name,
    parent_category_id,
    depth,
    category_path
FROM category_tree
ORDER BY category_path;
