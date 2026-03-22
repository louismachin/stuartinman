const allPages = document.querySelectorAll('.page')
const allNavLinks = document.querySelectorAll('nav a[data-page]')

let showPage = (id) => {
    allPages.forEach(p => p.classList.toggle('active', p.id === id))
    allNavLinks.forEach(a => a.classList.toggle('active', a.dataset.page === id))
    window.scrollTo({ top: 0, behavior: 'smooth' })
}

let nav = (id) => {
    showPage(id)
    closeMenu()
}

let openMenu = () => document.getElementById('mobileMenu').classList.add('open')
let closeMenu = () => document.getElementById('mobileMenu').classList.remove('open')