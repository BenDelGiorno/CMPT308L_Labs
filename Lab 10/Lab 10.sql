-- Ben DelGiorno
-- Lab 10
-- CMPT 308L

-- 1.function	PreReqsFor(courseNum)	-	Returns	the	immediate	prerequisites	for	the	
-- passed-in	course	number. 

create or replace function PreReqsFor(int) returns refcursor as
$$
declare
  queriedCourseNum int := $1;
  ref refcursor := 'result';
begin
  open ref for
    select num, name, credits
    from courses
    where num in(
      select preReqNum
      from prerequisites
      where courseNum = queriedCourseNum
    );
  return ref;
end;
$$
language plpgsql;

commit;
begin;
select PreReqsFor(449);
fetch all from result;


-- 2. func1on	IsPreReqFor(courseNum) -	Returns	the	courses	for	which	the	passed-in	course	
-- number is an immediate	pre-requisite.

create or replace function isPreReqFor(int) returns refcursor as
$$
declare
  queriedCourseNum int := $1;
  ref refcursor := 'result';
begin
  open ref for
    select num, name, credits
    from courses
    where num in(
      select courseNum
      from prerequisites
      where preReqNum = queriedCourseNum
    );
  return ref;
end;
$$
language plpgsql;

commit;
begin;
select isPreReqFor(120);
fetch all from result;