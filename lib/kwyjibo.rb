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
            c = Matriz.new(@cols, @rows)
            c.rows.times do |i|
                c.cols.times do |j|
                    c[i][j] = self[j][i]
                end
            end
            c
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
end