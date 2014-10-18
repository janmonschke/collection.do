var gulp = require('gulp');
var browserify = require('browserify');
var source = require('vinyl-source-stream');
var stylus = require('gulp-stylus');
var nib = require('nib');
var mocha = require('gulp-mocha');

var env = process.env.NODE_ENV || 'development';
var isDebugEnv = env == 'development';
var isProductionEnv = env == 'production';

gulp.task('browserify', function(){
    return browserify({
          entries: ['./app/app.js']
        })
        .bundle()
        .pipe(source('app.js'))
        .pipe(gulp.dest('./public/'));
});

gulp.task('stylus', function(){
  var stylusOptions = {
    use: [nib()],
    compress: isProductionEnv
  };
  return gulp.src('styles/app.styl')
        .pipe(stylus(stylusOptions))
        .pipe(gulp.dest('public/'))
});

gulp.task('test', function(){
  require('should');
  return gulp.src('test/**/*.js', {read: false})
        .pipe(mocha({reporter: 'dot'}));
});

gulp.task('watch', function(){
  gulp.watch('app/**/*.js', ['browserify', 'test']);
  gulp.watch('test/**/*.js', ['test']);
  // gulp.watch('server/**/*.coffee', ['test']);
  gulp.watch('styles/**/*.styl', ['stylus']);
});

gulp.task('default', ['browserify', 'stylus', 'test', 'watch']);