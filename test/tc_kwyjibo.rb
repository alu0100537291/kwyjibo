require 'test/unit'
require 'kwyjibo'

class Test_Kwyjibo < Test::Unit::TestCase
	def setup
		@a = Kwyjibo::DenseMatrix.new(2,2)
		@a[0][0] = Kwyjibo::Fraccion.new(1,1)
		@a[0][1] = Kwyjibo::Fraccion.new(2,1)
		@a[1][0] = Kwyjibo::Fraccion.new(3,1)
		@a[1][1] = 4

		@b = Kwyjibo::DenseMatrix.new(2,2)
		@b[0][0] = Kwyjibo::Fraccion.new(5,1)
		@b[0][1] = Kwyjibo::Fraccion.new(6,1)
		@b[1][0] = 7
		@b[1][1] = 8

		@c = Kwyjibo::SparseMatrix.new(2,3,0 => { 0 => Kwyjibo::Fraccion.new(5,1), 1 => 6})
	end

	def test_rows
		assert_equal(2,@a.rows)
		assert_equal(2,@b.rows)
		assert_not_equal(3,@a.rows)
		assert_not_equal(3,@b.rows)
	end

	def test_cols
		assert_equal(2,@a.cols)
		assert_equal(2,@b.cols)
		assert_not_equal(3,@a.cols)
		assert_not_equal(3,@b.cols)
	end

	def test_values
		assert_equal(Kwyjibo::Fraccion.new(1,1),@a[0][0])
		assert_equal(Kwyjibo::Fraccion.new(2,1),@a[0][1])
		assert_equal(3,@a[1][0])
		assert_equal(4,@a[1][1])
	end

	def test_plus
		d = @a + @b
		assert_equal(2,d.rows)
		assert_equal(2,d.cols)
		assert_equal(6,d[0][0])
		assert_equal(8,d[0][1])
		assert_equal(10,d[1][0])
		assert_equal(Kwyjibo::Fraccion.new(12,1),d[1][1])

		assert_raise(ArgumentError) {@a + @c}
	end

	def test_minus
		d = @a - @b
		assert_equal(2,d.rows)
		assert_equal(2,d.cols)
		assert_equal(-4,d[0][0])
		assert_equal(-4,d[0][1])
		assert_equal(-4,d[1][0])
		assert_equal(Kwyjibo::Fraccion.new(4,-1),d[1][1])

		assert_raise(ArgumentError) {@a - @c}
	end

	def test_product
	end

	def test_traspose
	end

	def test_max
	end

	def test_min
	end
end