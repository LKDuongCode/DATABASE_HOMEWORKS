#2
select b.title, b.author, c.category_name
from books b
join categories c on b.category_id = c.category_id
order by b.title;

select r.r_name, count(b.borrow_id) as total_borrowed
from readers r
left join borrowing b on r.reader_id = b.reader_id
group by r.reader_id, r.r_name;

select avg(f.fine_amount) as avg_fine
from fines f;

select title, available_quantity
from books
where available_quantity = (select max(available_quantity) from books);

select r.r_name, sum(f.fine_amount) as total_fine
from readers r
join borrowing b on r.reader_id = b.reader_id
join returning ret on b.borrow_id = ret.borrow_id
join fines f on ret.return_id = f.return_id
group by r.reader_id, r.r_name
having total_fine > 0;

select b.title, r.r_name, br.borrow_date
from borrowing br
join books b on br.book_id = b.book_id
join readers r on br.reader_id = r.reader_id
left join returning ret on br.borrow_id = ret.borrow_id
where ret.return_id is null
order by br.borrow_date;

select r.r_name, b.title
from borrowing br
join returning ret on br.borrow_id = ret.borrow_id
join books b on br.book_id = b.book_id
join readers r on br.reader_id = r.reader_id
where ret.return_date <= br.due_date;