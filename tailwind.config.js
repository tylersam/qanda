module.exports = {
  plugins: [require('daisyui')],
  content: [
    './config/initializers/form_errors.rb',
    './app/components/**/*.html.erb',
    './app/components/**/*.rb',
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
  ],
  daisyui: {
    themes: [
      {
        emerald: {
          ...require('daisyui/src/theming/themes')['[data-theme=emerald]'],
          '--padding-card': '1rem',
        },
      },
    ],
  },
}
