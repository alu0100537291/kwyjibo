require "kwyjibo/version"

module Kwyjibo
    class Matrix
        attr_reader :rows, :cols

        def initialize(rows,cols)
            @rows, @cols = rows, cols
        end

        def +(other)
            raise ArgumentError, "Matrix size must be equal" unless @rows == other.rows && @cols == other.cols
            c = DenseMatrix.new(@rows, @cols)
            @rows.times do |i|
                @cols.times do |j|
                    if self[i][j] == nil && other[i][j] == nil
                        c[i][j] = 0
                    elsif self[i][j] == nil && other[i][j] != nil
                        c[i][j] = other[i][j]
                    elsif self[i][j] != nil && other[i][j] == nil
                        c[i][j] = self[i][j]
                    else
                        c[i][j] = self[i][j] + other[i][j]
                    end
                end
            end
            c
        end

        def -(other)
            raise ArgumentError, "Matrix size must be equal" unless @rows == other.rows && @cols == other.cols
            c = DenseMatrix.new(@rows, @cols)
            @rows.times do |i|
                @cols.times do |j|
                    if self[i][j] == nil && other[i][j] == nil
                        c[i][j] = 0
                    elsif self[i][j] == nil && other[i][j] != nil
                        c[i][j] = -other[i][j]
                    elsif self[i][j] != nil && other[i][j] == nil
                        c[i][j] = self[i][j]
                    else
                        c[i][j] = self[i][j] - other[i][j]
                    end
                end
            end
            c
        end

        def *(other)
            raise ArgumentError, "Columns and Rows must be equal" unless (@cols == other.rows)
            c = DenseMatrix.new(@rows,other.cols)
            @rows.times do |i|
                other.cols.times do |j|
                    ac = 0
                    @cols.times do |k|
                        ac += self[i][k] * other[k][j] if (self[i][k] != nil && other[k][j] != nil)
                    end
                    c[i][j] = ac
                end
            end
            c
        end

        def max
            value = 0
            @rows.times do |i|
                @cols.times do |j|
                    if self[i][j] != nil
                        value = self[i][j] if self[i][j] > value
                    end
                end
            end
            value
        end

        def min
            value = self.max
            @rows.times do |i|
                @cols.times do |j|
                    if self[i][j] != nil
                        value = self[i][j] if self[i][j] < value
                    end
                end
            end
            value
        end
    end

    class DenseMatrix < Matrix
        attr_reader :data

        def initialize(rows,cols)
            @data = Array.new(rows) {Array.new(cols)}
            super
        end

        def [](i)
            @data[i]
        end

        def []=(i,value)
            @data[i] = value
        end

        def tras()
            c = DenseMatrix.new(@cols, @rows)
            c.rows.times do |i|
                c.cols.times do |j|
                    c[i][j] = self[j][i]
                end
            end
            c
        end

        def x(value)
            self.rows.times do |i|
                self.cols.times do |j|
                    self[i][j] *= 2
                end
            end
        end  
    end

    class SparseVector
        attr_reader :vector

        def initialize(h = {})
            @vector = Hash.new(0)
            @vector = @vector.merge!(h)
        end

        def [](i)
            @vector[i]
        end
    end

    class SparseMatrix < Matrix
        attr_reader :data

        def initialize(rows,cols, h = {})
            @data = Hash.new({})
            for k in h.keys do
                if h[k].is_a? SparseVector
                    @data[k] = h[k]
                else
                    @data[k] = SparseVector.new(h[k])
                end
            end
            super(rows,cols)
        end

        def [](i)
            @data[i]
        end
    end

    class Fraccion
        include Comparable

        attr_accessor :num, :denom

        def initialize(a, b)
            x = mcd(a,b)
            @num = a/x
            @denom = b/x

            if (@num < 0 && @denom < 0)
                @num = @num * -1
                @denom = @denom * -1
            end

            if (@denom < 0)
                @denom = @denom * -1
                @num = @num * -1
            end
        end

        def mcd(u, v)
           u, v = u.abs, v.abs
           while v != 0
              u, v = v, u % v
           end
           u
        end

        def to_s
            "#{@num}/#{@denom}"
        end

        def to_f
            @num.to_f/@denom.to_f
        end

        def +(other)
            if other.instance_of? Fixnum
                c = Fraccion.new(other,1)
                Fraccion.new(@num * c.denom + @denom * c.num, @denom * c.denom)
            else
                Fraccion.new(@num * other.denom + @denom * other.num, @denom * other.denom)
            end
        end

        def -(other)
            if other.instance_of? Fixnum
                c = Fraccion.new(other,1)
                Fraccion.new(@num * c.denom - @denom * c.num, @denom * c.denom)
            else
                Fraccion.new(@num * other.denom - @denom * other.num, @denom * other.denom)
            end
        end

        def *(other)
            if other.instance_of? Fixnum
                c = Fraccion.new(other,1)
                Fraccion.new(@num * c.num, @denom * c.denom)
            else
                Fraccion.new(@num * other.num, @denom * other.denom)
            end
        end

        def /(other)
            if other.instance_of? Fixnum
                c = Fraccion.new(other,1)
                Fraccion.new(@num * c.denom, @denom * c.num)
            else
                Fraccion.new(@num * other.denom, @denom * other.num)
            end        
        end

        def %(other)
            if other.instance_of? Fixnum
                c = Fraccion.new(other,1)
                division = Fraccion.new(@num * c.denom, @denom * c.num)
            else
                division = Fraccion.new(@num * other.denom, @denom * other.num)
            end  
            division.num % division.denom
        end

        def abs
            @num = @num.abs
            @denom = @denom.abs
        end

        def reciprocal
            x = @num
            @num = @denom
            @denom = x
        end

        def -@
            if (@num > 0)
                @num = @num * -1
            end
        end

        def <=>(other)
            return nil unless (other.instance_of? Fraccion) || (other.instance_of? Fixnum)
            if other.instance_of? Fixnum
                c = Fraccion.new(other,1)
                (@num.to_f/@denom.to_f) <=> (c.num.to_f/c.denom.to_f)
            else
                (@num.to_f/@denom.to_f) <=> (other.num.to_f/other.denom.to_f)
            end
        end

        def coerce(other)
            [self,other]
        end
    end
end